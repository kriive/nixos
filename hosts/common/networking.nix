{ pkgs, ... }:

{
  networking.wireless.enable = true;
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  networking.nftables.enable = true;

  systemd.sockets.ghidra-mcp-proxy = {
    wantedBy = [ "sockets.target" ];

    socketConfig = {
      ListenStream = "10.53.43.1:8089";
    };
  };

  systemd.services.ghidra-mcp-proxy = {
    serviceConfig = {
      ExecStart = "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd 127.0.0.1:8089";
    };
  };

  networking.firewall = {
    enable = true;
    checkReversePath = "loose";

    interfaces.incusbr0 = {
      allowedTCPPorts = [
        53
        8089
      ];
      allowedUDPPorts = [
        53
        67
        8089
      ];
    };
  };

  services.resolved.enable = true;
}
