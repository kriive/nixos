# DMS startup investigation

Measured on T14 on 2026-11-10, with the existing hardened allocator and DMS
settings, widgets, and plugins retained.

The figures below come from the previous runtime: nixpkgs Quickshell 0.3.2 with
both patches applied. DMS now embeds `dux-qt-base`, which already contains the
disk-cache fix, so the startup profile needs re-measuring.

## Results

| Measurement | Original runtime | Patched runtime |
| --- | ---: | ---: |
| Complete DMS service startup | 11.72 s at boot | 4.84 s on a warm restart |
| Launching QML to Configuration Loaded | 8.08 s at boot | 2.19 s on a warm restart |
| Controlled QML compilation probe | 8.22–8.26 s | 3.01–3.05 s with a populated cache |
| Scanning the installed DMS tree | 3.76 s | 0.51 s |

The first live launch with the patched runtime took 11.41 seconds while creating
the QML cache. The live measurements compare the earlier boot with subsequent
restarts; they are not measurements of another complete reboot. The separate
controlled probe confirms the improvement without boot-time contention.

## Changes

DMS embeds `dux-qt-base`, its Quickshell fork. The fork is built from
post-0.3.2 Quickshell plus the [upstream disk-cache fix](https://github.com/quickshell-mirror/quickshell/pull/1049)
at commit `97b62b85767bcdc3dc6c818e3584aca50fbf48e4`, so it creates the
file-backed mirror with content-based timestamps that lets Qt cache the QML.

`home/programs/dms.nix` replaces `programs.dank-material-shell.duxQtBase.package`
with the runtime the flake pins plus one local patch:

- A scanner optimization that indexes visited directories by canonical path,
  avoiding repeated filesystem-aware `QDir` comparisons. Files without
  conditional directives also stop scanning after their imports and pragmas.

File hashing, dependency discovery, generated module definitions, conditional
preprocessing, and file watching remain supported.

## Validation

The original and optimized scanners produced identical file lists, directory
lists, hashes, generated modules, and errors for all 1,097 files scanned from the
installed DMS tree. Additional cases cover singleton/internal declarations,
generated JSON-backed QML, nested conditionals, malformed conditionals, and
symlinked directory aliases. `dux-qt-base` keeps the same `scan.cpp` and
`scan.hpp` as Quickshell 0.3.2, so the comparison carries over.

The controlled probe compiles `ShellCore` and `DMSShell` inside uninstantiated QML
components. It creates no windows and uses private configuration, cache, runtime,
and D-Bus directories. Recreating its runtime directory between launches retained
the cache benefit. Probe timings exclude process teardown and are not complete
desktop-readiness measurements.

The full T14 system build, formatting, lint, and `nix flake check --no-build`
passed. Two approved live DMS restarts also succeeded. The final live process
uses the patched runtime, and its temporary systemd override was removed.

## Persistence and further measurement

Install the repository configuration to retain the change across service
restarts and reboots:

```sh
sudo nixos-rebuild switch --flake .#t14
```

The patched shell was running in the measured session. A new DMS version
or a cleared QML cache can make the first launch slower while rebuilding caches.

For later comparisons:

```sh
systemd-analyze --user blame
journalctl --user -b -u dms.service -o short-monotonic
```

Approximately 2.4 seconds of the measured warm startup follows initial QML
loading. Widget construction, asynchronous loaders, and theme initialization
overlap in this interval. Further improvement needs profiling those QML phases;
their individual log durations cannot simply be added or subtracted.
