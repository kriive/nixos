{ pkgs, ... }:
{
  imports = [ ../programs/fish.nix ];

  home.packages = with pkgs; [
    eza
    bat
    fastfetch
    htop
    btop
  ];

  home.shellAliases = {
    cat = "bat";
    ls = "eza";
  };

  programs = {
    ripgrep.enable = true;

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
  };

}
