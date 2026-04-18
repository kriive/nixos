{ lib, pkgs, ... }:

{
  virtualisation.docker.rootless.enable = lib.mkForce false;

  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  environment.systemPackages = lib.mkAfter [
    pkgs.xwayland-satellite
    pkgs.bibata-cursors
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "32";
  };
}
