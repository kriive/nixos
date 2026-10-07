{
  config,
  lib,
  pkgs,
  ...
}:
let
  bridgeName = "incusbr0";
  bridgeAddress = config.local.containers.ipv4Address;
  gateway = builtins.head (lib.splitString "/" bridgeAddress);
  ghidraPort = 8089;
in
{
  options.local.containers.ipv4Address = lib.mkOption {
    type = lib.types.strMatching "[0-9.]+/[0-9]+";
    description = "Incus bridge IPv4 address in CIDR notation; also used by the Ghidra proxy.";
  };

  config = {
    users.users.kriive.extraGroups = [
      "docker"
      "incus-admin"
    ];
    environment.systemPackages = with pkgs; [
      dnsmasq
      quickemu
      virt-viewer
    ];

    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
      rootless.enable = lib.mkForce false;
    };
    virtualisation.incus = {
      enable = true;
      package = pkgs.incus-lts;
      preseed = {
        networks = [
          {
            name = bridgeName;
            type = "bridge";
            config = {
              "ipv4.address" = bridgeAddress;
              "ipv4.nat" = "true";
              "ipv6.address" = "auto";
              "ipv6.nat" = "true";
            };
          }
        ];
        profiles = [
          {
            name = "default";
            devices = {
              eth0 = {
                name = "eth0";
                network = bridgeName;
                type = "nic";
              };
              root = {
                path = "/";
                pool = "default";
                type = "disk";
              };
            };
          }
        ];
        storage_pools = [
          {
            name = "default";
            driver = "dir";
            config.source = "/var/lib/incus/storage-pools/default";
          }
        ];
      };
    };

    networking.firewall.interfaces.${bridgeName} = {
      allowedTCPPorts = [
        53
        ghidraPort
      ];
      allowedUDPPorts = [
        53
        67
      ];
    };
    systemd.sockets.ghidra-mcp-proxy = {
      wantedBy = [ "sockets.target" ];
      socketConfig = {
        ListenStream = "${gateway}:${toString ghidraPort}";
        # Sockets start before Incus creates its bridge; allow the early bind.
        FreeBind = true;
      };
    };
    systemd.services.ghidra-mcp-proxy.serviceConfig.ExecStart =
      "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd 127.0.0.1:${toString ghidraPort}";
  };
}
