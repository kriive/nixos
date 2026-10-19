{
  boot.kernelParams = [ "btusb.enable_autosuspend=0" ];
  services.throttled.enable = true;
  services.thermald.enable = true;
}
