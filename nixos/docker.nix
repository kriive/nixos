{ lib, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.docker-sbx ];

  users.users.kriive.extraGroups = [
    "docker"
    "kvm"
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless.enable = lib.mkForce false;
  };
}
