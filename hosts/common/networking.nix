{ ... }:

{
  networking.wireless.enable = true;
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
  };

  services.resolved.enable = true;
}
