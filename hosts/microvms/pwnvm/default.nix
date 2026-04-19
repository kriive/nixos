{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  pwnTooling = import ./pwn-tooling.nix {
    inherit inputs lib pkgs;
  };
  inherit (pwnTooling) nixLdLibs pwnCliPkgs;
  vmAddress = "10.42.0.2/24";
  vmGateway = "10.42.0.1";
  vmMacAddress = "02:00:00:00:10:01";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  networking.hostName = "pwnvm";
  networking.useNetworkd = true;
  system.stateVersion = "25.11";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.pwn = ../../../hm/hosts/microvms/pwnvm;
  };

  nix = {
    channel.enable = false;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
  };

  nixpkgs.flake = {
    setFlakeRegistry = true;
    setNixPath = true;
    source = inputs.nixpkgs.outPath;
  };

  microvm = {
    hypervisor = "cloud-hypervisor";
    vcpu = 2;
    mem = 4096;
    interfaces = [
      {
        id = "vm-pwn";
        mac = vmMacAddress;
        type = "tap";
      }
    ];
    shares = [
      {
        mountPoint = "/nix/.ro-store";
        proto = "virtiofs";
        source = "/nix/store";
        tag = "ro-store";
      }
      {
        mountPoint = "/home/pwn/pwn";
        proto = "virtiofs";
        source = "/home/kriive/pwn";
        tag = "host-pwn";
      }
    ];
    volumes = [
      {
        image = "nix-store-overlay.img";
        mountPoint = config.microvm.writableStoreOverlay;
        size = 20480;
      }
      {
        image = "ssh-host-keys.img";
        mountPoint = "/var/lib/ssh";
        size = 64;
      }
    ];
    writableStoreOverlay = "/nix/.rw-store";
  };

  programs.bash.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = nixLdLibs;

  security.unprivilegedUsernsClone = true;
  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    hostKeys = [
      {
        path = "/var/lib/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/var/lib/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
    ];
    openFirewall = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.pwn = {
    isNormalUser = true;
    description = "Pwn user";
    group = "users";
    extraGroups = [ "wheel" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMiWlG8ftLKl0tcuSjOsEMcxMM1Kmrl/cSwHavpnf6k7 kriive@nix-thinkpad"
    ];
    shell = pkgs.bashInteractive;
  };

  services.getty.autologinUser = "pwn";

  systemd.network.enable = true;
  systemd.network.networks."20-pwnvm" = {
    matchConfig.MACAddress = vmMacAddress;
    addresses = [
      {
        Address = vmAddress;
      }
    ];
    networkConfig = {
      DHCP = "no";
      DNS = [
        "1.1.1.1"
        "9.9.9.9"
      ];
    };
    routes = [
      {
        Destination = "0.0.0.0/0";
        Gateway = vmGateway;
      }
    ];
  };

  environment.systemPackages = pwnCliPkgs;
}
