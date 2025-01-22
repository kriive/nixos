{ pkgs, inputs, ... }:

{
  imports = [
    ../thinkpad/home/helix.nix
  ];

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";

  home.packages = with pkgs; [
    eza
    bat
    distrobox
    fastfetch
    inputs.fish-nixpkgs.legacyPackages."${pkgs.system}".fishPlugins.tide
  ];

  fonts.fontconfig.enable = true;

  home.shellAliases = {
    cat = "bat";
    ls = "eza";
  };

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = with pkgs.fishPlugins; [{
        name = "tide";
        inherit (tide) src;
      }];
      package = inputs.fish-nixpkgs.legacyPackages."${pkgs.system}".fish;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    bash = { enable = true; };
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
