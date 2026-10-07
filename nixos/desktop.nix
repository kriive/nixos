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
  niri-flake.cache.enable = true;
  # DMS provides the session's polkit agent.
  systemd.user.services.niri-flake-polkit.enable = false;

  programs.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = config.users.users.kriive.home;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };

  programs.seahorse.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
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
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    sarasa-gothic
  ];

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.printing.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.flatpak.enable = true;
  services.accounts-daemon.enable = true;
  # Existing compatibility exception; original symptom needs runtime confirmation.
  # Keep until the greeter/account integration is verified without it (docs/workarounds.md).
  systemd.services.accounts-daemon.serviceConfig.PrivateTmp = false;
}
