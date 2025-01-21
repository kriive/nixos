{ ... }:

{
  networking.hostName = "pwn";
  users.users.root.password = "";

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitEmptyPasswords = "yes";
      PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  microvm = {
    volumes = [{
      mountPoint = "/var";
      image = "var.img";
      size = 256;
    }];
    interfaces = [{
      type = "user";
      id = "vm-a1";
      mac = "02:00:00:00:00:01";
    }];
    shares = [{
      # use proto = "virtiofs" for MicroVMs that are started by systemd
      proto = "virtiofs";
      tag = "ro-store";
      # a host's /nix/store will be picked up so that no
      # squashfs/erofs will be built for it.
      source = "/nix/store";
      mountPoint = "/nix/.ro-store";
    }];

    forwardPorts = [
      { host.port = 2222; guest.port = 22; }
    ];

    # "qemu" has 9p built-in!
    hypervisor = "qemu";
    socket = "control.socket";
  };
}
