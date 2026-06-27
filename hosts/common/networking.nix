{ ... }:

{
  networking.wireless.enable = true;
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;
    checkReversePath = "loose";

    interfaces.incusbr0 = {
      allowedTCPPorts = [
        53
        67
      ];
      allowedUDPPorts = [
        53
        67
      ];
    };
  };

  services.resolved.enable = true;
}
