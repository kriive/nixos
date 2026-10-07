# Compatibility notes

Keep exceptions with the feature or host that needs them. Record the upstream
reference, affected dependency, and a concrete condition for removal. Check this
file when updating `flake.lock`.

## Active exceptions

| Configuration | Reason and scope | Review/removal condition |
| --- | --- | --- |
| `hosts/t14/touchpad.nix` | Four local patches from `orospakr/thinkpad-t14-amd-touchpad` at `03cdbb1857f5b9a6fbcef52a0f982d56edb99f5f`, originally based on Linux 7.2.3. The current kernel baseline is 7.2.9. | Compare with upstream at each kernel update, build `.#t14-kernel`, and verify touchpad and suspend/resume on T14. Remove individual patches when upstream contains them. |
| `hosts/t14/power.nix` | Configures battery-aware power-profiles-daemon actions through its CLI; the pinned NixOS module exposes only enable/package options. | Replace the script when equivalent declarative options become available. Verify the CLI output and action names after daemon updates. |
| `hosts/t15/default.nix` | Forces the Xe driver for device `9a49`, blacklists i915, disables Bluetooth USB autosuspend, and supplies touchpad pressure thresholds. | Preserve until tested on T15 with newer kernel/driver defaults; original issue references were not recorded. |
| `hosts/t15/security.nix` | Preserves 19 module restrictions from the former Kicksecure blacklist that are not included in the current nix-mineral groups. | Remove individual entries when the upstream groups cover them, or after deliberately reviewing the hardware/security policy. |
| `nixos/desktop.nix`: AccountsService `PrivateTmp=false` | Existing exception preserved from the prior configuration. The original symptom was not documented. | Test the greeter/account integration with the default sandbox before removing. Do not assume the exception remains necessary. |
| `pkgs/ghidra.nix` | Provides scaled and unscaled Ghidra launchers with custom desktop entries. | Review launcher arguments after Ghidra updates; use an upstream package option if one becomes available. |
| `overlays/pwntools.nix` | Uses the locked pwntools `dev` source for the development environment. | Drop the overlay when the Nixpkgs release provides the required functionality; the original feature requirement was not recorded. |

## Security policy

Both laptops explicitly import `nixos/hardening.nix`. It retains nix-mineral's
maximum preset with desktop/virtualization exceptions: runtime module loading,
Bluetooth, multilib, forwarding, and TCP window scaling. The T14 IOMMU exceptions
remain host-local.

Global hardened-malloc is disabled. The pinned upstream module labels it
testing-only, and the previous setup required namespace wrappers for Chromium,
Vesktop, and Incus/qemu-img. Removing the global preload removes that compatibility
problem without obscuring `/etc` from individual applications. Related browser
issue: <https://issues.chromium.org/issues/486362478>.

`wheel`, `docker`, `incus-admin`, and Nix trusted-user access remain intentional
administrative privileges for `kriive`; they are not an isolation boundary from
host root.

## Retired workarounds

- **fwupd EFI location override:** the pinned Nixpkgs package already sets
  `efi_app_location=/run/fwupd-efi`. The custom override only reordered the same
  flags and created a different derivation.
- **Manual coredump policy:** the pinned nix-mineral now uses
  `systemd.coredump.settings`; its supported coredump policy replaces the local
  sysctl/PAM/systemd copy.
- **T15 Intel ME/Kicksecure file rewrites:** the maximum preset already enables
  `nix-mineral.kernel-modules.disable.intelme-related` and generates its own
  store-backed blocking helper. The legacy Kicksecure option is deprecated.
  Additional restrictions from that file are retained using supported per-module
  options in `hosts/t15/security.nix`.
- **`pnpm-10.29.2` insecure-package allowance:** removed from T14; reevaluate the
  full host to detect any package that still requires it rather than retaining
  an unexplained exception.

## DMS settings

`home/programs/dms/settings.nix` keeps deliberate appearance and widget settings.
Redundant dock fields use the pinned DMS normalizer's defaults. The schema version,
floating-rule seed marker, and connected-frame restoration state are retained
because upstream uses them for migrations and behavior; they are not unused data.
Host power-profile differences live in `hosts/t14/home.nix`.
