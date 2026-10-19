{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
    inputs.dank-greeter.nixosModules.default
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  nixpkgs.config.chromium.enableWideVine = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  # DMS provides the session's polkit agent.
  systemd.user.services.niri-flake-polkit.enable = false;
  security.polkit.enablePkexecWrapper = true;

  programs.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = config.users.users.kriive.home;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };

  hardware.graphics.enable32Bit = true;
  # Niri supplies the GNOME portal, Polkit, and GNOME Keyring.
  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
    };
  };

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
