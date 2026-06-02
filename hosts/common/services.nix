{ ... }:

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
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  security.polkit.enable = true;
}
