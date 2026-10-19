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

| Updated software | Action |
| --- | --- |
| Linux or graphics drivers | Test graphics and the touchpad. Test suspend, resume, and Bluetooth. |
| power-profiles-daemon | Test the T14 power profiles on battery power and external power. |
| Chromium, Vesktop, or Signal Desktop | Start each application. |
| DMS | Test the bar, widgets, and lock screen. |

Keep the existing `system.stateVersion` and `home.stateVersion` values during package updates.

Before you change the DMS `configVersion`, convert the settings to the new format.

Remove a [T14 touchpad patch](../hosts/t14/touchpad.nix) only when the kernel includes its fix.
Keep the T15 driver settings until the default settings work on that laptop.
Keep the AccountsService exception until the login screen works with the default sandbox.

For kernel errors on T14, build the kernel separately:

```sh
nix build --no-link .#t14-kernel
```
