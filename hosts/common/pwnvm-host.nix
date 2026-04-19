{
  inputs,
  lib,
  ...
}:

{
  imports = [ inputs.microvm.nixosModules.host ];

  networking.nat = {
    enable = true;
    internalIPs = [ "10.42.0.0/24" ];
  };

  networking.networkmanager.unmanaged = lib.mkAfter [
    "interface-name:microvm"
    "interface-name:vm-*"
  ];

  systemd.network = {
    enable = true;
    wait-online.enable = false;

    netdevs."10-microvm".netdevConfig = {
      Kind = "bridge";
      Name = "microvm";
    };

    networks."10-microvm" = {
      matchConfig.Name = "microvm";
      addresses = [
        {
          Address = "10.42.0.1/24";
        }
      ];
      linkConfig.RequiredForOnline = "no";
      networkConfig.ConfigureWithoutCarrier = true;
    };

    networks."11-microvm-taps" = {
      matchConfig.Name = "vm-*";
      linkConfig.RequiredForOnline = "no";
      networkConfig.Bridge = "microvm";
    };
  };

  microvm.vms.pwnvm = {
    specialArgs = { inherit inputs; };
    config = import ../../hosts/microvms/pwnvm;
  };
}
