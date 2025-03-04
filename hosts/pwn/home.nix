{ pkgs, inputs, ... }:

{
  imports = [
    ../../home-manager/shell-goodies.nix
  ];

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
