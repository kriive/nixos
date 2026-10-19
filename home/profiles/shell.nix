{ pkgs, ... }:
{
  imports = [
    ../programs/fish.nix
    ../programs/nix-index.nix
    ../programs/rbw.nix
  ];

  home.packages = with pkgs; [
    eza
    bat
    fastfetch
    htop
    btop
    unzip
    zip
    p7zip
    ethtool
    dig
    mtr
  ];

  home.shellAliases = {
    cat = "bat";
    ls = "eza";
  };

  programs = {
    ripgrep.enable = true;

    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };

    bash = {
      enable = true;
    };
  };

}
