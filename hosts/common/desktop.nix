{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  niri-flake.cache.enable = true;
  systemd.user.services.niri-flake-polkit.enable = false;

  programs.seahorse.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    bibata-cursors
  ];

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "32";
  };
}
