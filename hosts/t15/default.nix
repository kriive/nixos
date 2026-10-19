{
  imports = [
    ../../nixos/base.nix
    ../../nixos/laptop.nix
    ../../nixos/desktop.nix
    ../../nixos/docker.nix
    ../../nixos/hardening.nix
    ../../nixos/virtualization/tools.nix
    ./hardware-configuration.nix
    ./graphics.nix
    ./power.nix
    ./touchpad.nix
    ./security.nix
  ];

  system.stateVersion = "25.11";
  home-manager.users.kriive.imports = [ ../../home/kriive.nix ];
}
