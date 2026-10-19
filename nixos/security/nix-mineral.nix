{ inputs, lib, ... }:
{
  imports = [ inputs.nix-mineral.nixosModules.nix-mineral ];

  services.usbguard.enable = false;
  boot.kernel.sysctl."kernel.dmesg_restrict" = lib.mkForce 1;

  nix-mineral = {
    enable = true;
    preset = "maximum";
    # Hot-plugged devices and virtual machines require runtime module loading.
    kernel-modules.load = true;
    kernel-modules.disable.bluetooth-related = false;
    # Keep global preloading; Chromium/Electron additionally need allocator-compat.nix.
    extras.system.hardened-malloc = true;
    settings.debug.coredump = false;
    settings.etc.harden-bluetooth = false;
    filesystems.enable = false;
    settings.network = {
      ip-forwarding = true;
      arp.ignore = "local";
    };
    settings.system.multilib = true;
    extras.network.tcp-window-scaling = true;
  };
}
