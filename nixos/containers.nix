{ lib, pkgs, ... }:
{
  users.users.kriive.extraGroups = [ "docker" ];

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
}
