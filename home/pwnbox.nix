{
  imports = [
    ./profiles/shell.nix
    ./profiles/development.nix
    ./profiles/pwn.nix
  ];

  # Match cloud-init.yaml and the pwnbox launcher in home/kriive.nix.
  home.username = "kriive";
  home.homeDirectory = "/home/kriive";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
