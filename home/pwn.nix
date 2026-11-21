{ pkgs, ... }:
{
  imports = [
    ./profiles/pwn.nix
    ./programs/fish.nix
    ./programs/helix.nix
    ./programs/zellij.nix
  ];

  home.packages = with pkgs; [
    nixfmt
    ruff
  ];

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
