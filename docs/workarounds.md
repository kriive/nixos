# Maintenance notes

## Security

Both laptops use the maximum nix-mineral preset.
Both laptops enable hardened malloc.
The nix-mineral project marks this allocator option for tests only.
Some applications use their own memory allocator.

Chromium, Vesktop, and Signal Desktop also use [startup fixes](../home/programs/allocator-compat.nix).
Firefox instead hides the system preload list in a mount namespace, because its bundled mozjemalloc is incompatible with hardened malloc.
Keep these fixes until the applications start correctly without them.

The `wheel` and `docker` groups give administrator access.
Nix trusted users also have administrator access.

## After package updates

| Updated software | Action |
| --- | --- |
| Linux or graphics drivers | Test graphics and the touchpad. Test suspend, resume, and Bluetooth. |
| power-profiles-daemon | Test the T14 power profiles on battery power and external power. |
| Chromium, Firefox, Vesktop, or Signal Desktop | Start each application. |
| DMS | Test the bar, widgets, and lock screen. |

Keep the existing `system.stateVersion` and `home.stateVersion` values during package updates.

Before you change the DMS `configVersion`, convert the settings to the new format.

DMS runs on `dux-qt-base`, the Quickshell fork it embeds. The fork already
contains [upstream PR #1049](https://github.com/quickshell-mirror/quickshell/pull/1049)
at commit `97b62b85767bcdc3dc6c818e3584aca50fbf48e4`, which enables QML disk caching.
DMS uses the default runtime supplied by its module, without local patches.
The first launch populates the QML cache, so measure a later launch or reboot too.
See the [historical DMS startup measurements](dms-startup.md) for earlier timing details.

Remove a [T14 touchpad patch](../hosts/t14/touchpad.nix) only when the kernel includes its fix.
Keep the T15 driver settings until the default settings work on that laptop.
Keep the AccountsService exception until the login screen works with the default sandbox.

If the touchpad stops tracking small movements, run `touchpad-reset` in a terminal.
This shell alias unloads `psmouse`, waits five seconds, and loads it again using sudo.
The touchpad and TrackPoint are unavailable during the reset.

Use `charge-100` to allow a full battery charge, or `charge-80` to stop charging at 80%.
The latter resumes charging below 75%; full charging resumes below 99%.
Both shell aliases use sudo to update the BAT0 charge thresholds immediately.
Setting the 80% limit does not discharge a battery that is already above 80%.

For kernel errors on T14, build the kernel separately:

```sh
nix build --no-link .#t14-kernel
```
