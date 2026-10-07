{ inputs, lib, ... }:
{
  imports = [ inputs.nix-mineral.nixosModules.nix-mineral ];

  security.doas.enable = lib.mkForce false;
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
    defaultOptions = [ ];
  };
  services.usbguard.enable = false;
  boot.kernel.sysctl."kernel.dmesg_restrict" = lib.mkForce 1;

  nix-mineral = {
    enable = true;
    preset = "maximum";
    # Hot-plugged devices and virtual machines require runtime module loading.
    kernel-modules.load = true;
    kernel-modules.disable.bluetooth-related = false;
    # Global allocator preloading broke Chromium/Electron and qemu-img.
    # Use the system allocator rather than maintaining per-application namespaces.
    extras.system.hardened-malloc = false;
    extras.system.secure-chrony = true;
    settings.debug.coredump = false;
    settings.etc.kicksecure-bluetooth = false;
    filesystems.enable = false;
    settings.network = {
      ip-forwarding = true;
      arp.ignore = "local";
    };
    settings.system.multilib = true;
    extras.network.tcp-window-scaling = true;
  };
}
