{ inputs, lib, pkgs, ... }:
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

  # Local replacement for nix-mineral's deprecated secure-chrony extra.
  services.timesyncd.enable = lib.mkDefault false;
  services.chrony = {
    enable = lib.mkDefault true;
    extraFlags = lib.mkDefault [ "-F 1" "-r" ];
    enableRTCTrimming = lib.mkDefault false;
    servers = lib.mkDefault [ ];
    initstepslew.enabled = lib.mkDefault false;
    extraConfig = lib.mkDefault ''
      server time.cloudflare.com iburst nts
      server ntppool1.time.nl iburst nts
      server nts.netnod.se iburst nts
      server ptbtime1.ptb.de iburst nts
      server time.dfm.dk iburst nts
      server time.cifelli.xyz iburst nts

      minsources 3
      authselectmode require
      dscp 46
      driftfile /var/lib/chrony/drift
      dumpdir /var/lib/chrony
      ntsdumpdir /var/lib/chrony
      leapseclist ${pkgs.tzdata}/share/zoneinfo/leap-seconds.list
      makestep 1.0 3
      rtconutc
      rtcsync
      cmdport 0
      noclientlog
    '';
  };

  nix-mineral = {
    enable = true;
    preset = "maximum";
    # Hot-plugged devices and virtual machines require runtime module loading.
    kernel-modules.load = true;
    kernel-modules.disable.bluetooth-related = false;
    # Global allocator preloading broke Chromium/Electron and qemu-img.
    # Use the system allocator rather than maintaining per-application namespaces.
    extras.system.hardened-malloc = true;
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
