{ inputs, pkgs, ... }:

{
  imports = [
    ../../modules/shell-core.nix
    inputs.nix-index-database.homeModules.default
  ];

  programs.helix = {
    languages = {
      language-server.clangd = {
        command = "clangd";
      };
      language = [
        {
          name = "c";
          language-servers = [ "clangd" ];
        }
        {
          name = "cpp";
          language-servers = [ "clangd" ];
        }
      ];
    };
  };

  home.packages = with pkgs; [
    clang-tools
  ];

  programs = {
    nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    nix-index-database.comma.enable = true;
  };
}
