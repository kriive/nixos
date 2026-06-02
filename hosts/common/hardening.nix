{ inputs, lib, ... }:

{
  imports = [
    inputs.nix-mineral.nixosModules.nix-mineral
  ];

  security.doas.enable = lib.mkForce false;
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
    defaultOptions = [ ];
  };

  # nix-mineral still uses the removed systemd.coredump.extraConfig option here.
  # Keep the same hardening with the current NixOS option instead.
  systemd.coredump.settings.Coredump.Storage = lib.mkDefault "none";
  boot.kernel.sysctl = {
    "fs.suid_dumpable" = lib.mkDefault "0";
    "kernel.core_pattern" = lib.mkDefault "|/bin/false";
  };
  security.pam.loginLimits = [
    {
      domain = lib.mkDefault "*";
      item = lib.mkDefault "core";
      type = lib.mkDefault "hard";
      value = lib.mkDefault "0";
    }
  ];

  nix-mineral = {
    enable = lib.mkDefault false;
    preset = "maximum";
    extras.system.hardened-malloc = true;
    extras.system.unprivileged-userns = true;
    extras.system.secure-chrony = true;
    extras.misc.usbguard.enable = false;
    extras.network.bluetooth-kmodules = true;
    settings.debug.coredump = true;
    settings.etc.kicksecure-bluetooth = false;
    settings.network.ip-forwarding = true;
    filesystems.enable = false;
    settings.system.multilib = true;
    extras.network.tcp-window-scaling = true;
  };
}
