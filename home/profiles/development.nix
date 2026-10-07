{ pkgs, ... }:

let
  pythonLsp = pkgs.python3.withPackages (
    ps: with ps; [
      python-lsp-server
      pwntools
    ]
  );
in
{
  imports = [
    ../programs/helix.nix
    ../programs/tmux.nix
    ../programs/zellij.nix
  ];

  programs.git.enable = true;
  programs.helix = {
    languages = {
      language-server.clangd.command = "${pkgs.clang-tools}/bin/clangd";
      language-server.pylsp = {
        command = "${pythonLsp}/bin/pylsp";
        config.pylsp.plugins = {
          autopep8.enabled = false;
          flake8.enabled = false;
          mccabe.enabled = false;
          pycodestyle.enabled = false;
          pyflakes.enabled = false;
          pylint.enabled = false;
          yapf.enabled = false;
        };
      };
      language-server.ruff = {
        command = "ruff";
        args = [ "server" ];
        config.settings.lint.ignore = [
          "F403"
          "F405"
        ];
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
        {
          name = "nix";
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "python";
          language-servers = [
            "ruff"
            {
              name = "pylsp";
              except-features = [
                "diagnostics"
                "format"
              ];
            }
          ];
        }
      ];
    };
  };

  home.packages = with pkgs; [
    clang-tools
    ruff
    nixfmt
  ];
}
