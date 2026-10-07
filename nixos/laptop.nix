{
  imports = [ ./boot.nix ];

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.upower.enable = true;
  services.hardware.bolt.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;
}
