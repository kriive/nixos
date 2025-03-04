{ pkgs, inputs, ... }:

{
  imports = [
    ../../home-manager/helix.nix
    ../../home-manager/fish.nix
    ../../home-manager/tmux.nix
  ];

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";

  home.packages = with pkgs; [
    eza
    bat
    swayosd
    fastfetch
    senpai
    ghidra
    htop
    btop
    nixfmt-rfc-style
    inputs.fish-nixpkgs.legacyPackages."${pkgs.system}".fishPlugins.tide
  ];

  fonts.fontconfig.enable = true;

  home.shellAliases = {
    cat = "bat";
    ls = "eza";
  };

  programs = {
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    bash = {
      enable = true;
    };

    wlogout = {
      enable = true;
    };
  };

  services = {
    swayosd.enable = true;
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
