{ inputs, ... }:

{
  networking.hostName = "pwn";

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "kriive" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  users.users.kriive = {
    isNormalUser = true;
    password = "test";
    description = "Manuel Romei";
    extraGroups = [ "wheel" ];
  };

  virtualisation.containers.enable = true;

  virtualisation.containers.storage.settings.storage = {
    rootless_storage_path = "/containers/nonroot";
    graphroot = "/containers/graphroot";
    runroot = "/containers/runroot";
  };

  virtualisation.containers.containersConf.settings.engine = {
    env = ["TMPDIR=/containers/tmpdir"];
  };

  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Enable Home Manager.
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.kriive = import ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };

  microvm = {
    vcpu = 2;
    mem = 4096;

    volumes = [
      {
        mountPoint = "/var";
        image = "var.img";
        size = 256;
      }
      {
        mountPoint = "/containers";
        image = "containers.img";
        size = 20000;
      }
    ];

    interfaces = [{
      type = "user";
      id = "vm-a1";
      mac = "02:00:00:00:00:01";
    }];

    shares = [
      {
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
      {
        proto = "virtiofs";
        tag = "home2";
        source = "/home/kriive/pwn";
        mountPoint = "/home/kriive";
      }
    ];

    forwardPorts = [
      { host.port = 2222; guest.port = 22; }
    ];

    # "qemu" has 9p built-in!
    hypervisor = "qemu";
    socket = "control.socket";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
