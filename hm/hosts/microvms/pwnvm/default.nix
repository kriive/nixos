{
  pkgs,
  ...
}:

{
  imports = [
    ../../common/shell-goodies.nix
    ./pwn-fhs.nix
  ];

  home.homeDirectory = "/home/pwn";
  home.stateVersion = "25.11";
  home.username = "pwn";

  programs.home-manager.enable = true;
}
