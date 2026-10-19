{
  imports = [
    ./profiles/shell.nix
    ./profiles/development.nix
    ./profiles/desktop.nix
  ];

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
