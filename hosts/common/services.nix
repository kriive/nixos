{ lib, pkgs, ... }:

let
  fwupdPackage = pkgs.fwupd.overrideAttrs (old: {
    mesonFlags =
      lib.filter
        (flag: !lib.hasPrefix "-Defi_app_location=" flag)
        (old.mesonFlags or [])
      ++ [ (lib.mesonOption "efi_app_location" "/run/fwupd-efi") ];
  });
in

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.printing.enable = true;
  services.upower.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.hardware.bolt.enable = true;
  services.flatpak.enable = true;
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  services.fwupd = {
    enable = true;
    package = fwupdPackage;
  };
  services.power-profiles-daemon.enable = true;

  security.polkit.enable = true;
}
