{ lib, ... }:
{
  users.users.kriive.extraGroups = [ "docker" ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless.enable = lib.mkForce false;
  };
}
