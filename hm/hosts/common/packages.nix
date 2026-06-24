{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    adw-gtk3
    telegram-desktop
    gnome-podcasts
    ioskeley-mono.normal-term-NF
    wineWow64Packages.waylandFull
    winetricks
    delfin
    unzip
    zip
    p7zip
    ethtool
    inputs.codex.packages.${pkgs.stdenv.hostPlatform.system}.default
    dig
    mtr
    jujutsu
  ];
}
