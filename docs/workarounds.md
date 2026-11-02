# Maintenance notes

## Security

Both laptops use the maximum nix-mineral preset.
Both laptops enable hardened malloc.
The nix-mineral project marks this allocator option for tests only.
Some applications use their own memory allocator.

Chromium, Vesktop, and Signal Desktop also use [startup fixes](../home/programs/allocator-compat.nix).
Keep these fixes until the applications start correctly without them.

The `wheel` and `docker` groups give administrator access.
Nix trusted users also have administrator access.

## After package updates

The pinned nix-mineral quiet-boot setting still defines the removed
`boot.initrd.verbose` option. It is disabled in `nixos/security/nix-mineral.nix`;
`nixos/boot.nix` preserves its supported console and kernel logging settings.
Remove this workaround when nix-mineral stops defining the removed option.

| Updated software | Action |
| --- | --- |
| Linux or graphics drivers | Test graphics and the touchpad. Test suspend, resume, and Bluetooth. |
| power-profiles-daemon | Test the T14 power profiles on battery power and external power. |
| Chromium, Vesktop, or Signal Desktop | Start each application. |
| DMS | Test the bar, widgets, and lock screen. |

Keep the existing `system.stateVersion` and `home.stateVersion` values during package updates.

The `khal` override in `flake.nix` passes `sphinxBuilders` as a string.
The pinned Sphinx hook reads only the first builder when this value is a Bash array
under structured attributes, so the manual output is never created.
Remove the override once the Sphinx hook handles arrays correctly.

Before you change the DMS `configVersion`, convert the settings to the new format.

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
