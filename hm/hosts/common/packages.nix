{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    adw-gtk3
    telegram-desktop
    gnome-podcasts
    ioskeley-mono.term-nf
    wineWow64Packages.waylandFull
    winetricks
    delfin
    unzip
    zip
    p7zip
    ethtool
    codex
    dig
    mtr
    jujutsu
    signal-desktop
  ];
}
