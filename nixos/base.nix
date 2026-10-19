{ pkgs, ... }:
{
  imports = [
    ./locale.nix
    ./networking.nix
    ./users.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "kriive"
    ];
  };
  documentation.man.enable = true;
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    helix
    git
    bubblewrap
  ];
}
