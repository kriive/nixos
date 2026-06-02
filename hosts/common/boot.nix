{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Lanzaboote currently replaces the systemd-boot module.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.timeout = 0;

  # Use systemd-based initrd, to enable fancy Plymouth stuff.
  boot.initrd.systemd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "btusb.enable_autosuspend=0"
    "psmouse.synaptics_intertouch=1"
  ];

  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };
}
