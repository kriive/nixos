{
  pkgs,
  ...
}:

{
  imports = [
    ../../shared/shell-core.nix
  ];

  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";
  home.stateVersion = "26.05";

  home.packages = import ./packages.nix { inherit pkgs; };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.home-manager.enable = true;
}
