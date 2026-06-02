{ lib, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless.enable = lib.mkForce false;
  };

  virtualisation.multipass-ng.enable = true;
}
