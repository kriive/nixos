{ pkgs, ... }:
{
  imports = [
    ../programs/appearance.nix
    ../programs/chromium.nix
    ../programs/dms.nix
    ../programs/fonts.nix
    ../programs/foot.nix
    ../programs/ghidra.nix
    ../programs/go-librespot.nix
    ../programs/imv.nix
    ../programs/mpv.nix
    ../programs/niri.nix
    ../programs/spotify-player.nix
    ../programs/zathura.nix
    ../programs/zed.nix
  ];
  programs.vesktop.enable = true;
  home.packages = with pkgs; [
    telegram-desktop
    gnome-podcasts
    ioskeley-mono.term-nf
    wineWow64Packages.waylandFull
    winetricks
    delfin
    signal-desktop
  ];
}
