{ pkgs, ... }:
{
  imports = [
    ./profiles/shell.nix
    ./profiles/development.nix
    ./profiles/desktop.nix
    ./programs/kubernetes.nix
    ./programs/nix-index.nix
    ./programs/opencode.nix
    ./programs/rbw.nix
  ];

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
  home.shellAliases.pwnbox = "incus exec pwnbox --mode=interactive -- sudo -iu kriive fish -l";
  home.packages = with pkgs; [
    unzip
    zip
    p7zip
    ethtool
    codex
    dig
    mtr
    jujutsu
  ];
}
