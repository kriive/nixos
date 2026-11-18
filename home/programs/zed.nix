{
  pkgs,
  ...
}:
let
  paneNavigation = {
    "ctrl-h" = "workspace::ActivatePaneLeft";
    "ctrl-l" = "workspace::ActivatePaneRight";
    "ctrl-k" = "workspace::ActivatePaneUp";
    "ctrl-j" = "workspace::ActivatePaneDown";
  };
in
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "lua"
      "basher"
    ];
    extraPackages = [ pkgs.nixd ];
    mutableUserKeymaps = false;

    userSettings = {
      helix_mode = true;
      theme = {
        mode = "system";
        dark = "DankShell Dark";
        light = "DankShell Light";
      };
      buffer_font_family = "TX02 Nerd Font Mono";
      buffer_font_size = 16;
      soft_wrap = "editor_width";
      current_line_highlight = "all";
      hover_popover_delay = 75;
      vim.cursor_shape = {
        normal = "block";
        insert = "bar";
        visual = "underline";
      };
      diagnostics.inline = {
        enabled = true;
        max_severity = "hint";
      };
      terminal = {
        font_family = "TX02 Nerd Font Mono";
        font_size = 16;
        shell.program = "${pkgs.zellij}/bin/zellij";
        working_directory = "current_project_directory";
      };
      languages.Go = {
        language_servers = [ "gopls" ];
        format_on_save = "on";
        formatter = "language_server";
        code_actions_on_format."source.organizeImports" = true;
      };
      languages.YAML = {
        language_servers = [ "yaml-language-server" ];
        formatter = "language_server";
      };
      dap.Delve.binary = "${pkgs.delve}/bin/dlv";
      file_finder = {
        modal_width = "medium";
      };
      tab_bar = {
        show = true;
      };
      tabs = {
        show_diagnostics = "errors";
      };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      inlay_hints = {
        enabled = false;
      };
      active_pane_modifiers.inactive_opacity = 0.5;

      assistant = {
        enabled = false;
      };

      hour_format = "hour24";
      auto_update = false;

      # File syntax highlighting
      file_types = {
        JSON = [
          "json"
          "jsonc"
          "*.code-snippets"
        ];
      };
      lsp = {
        yaml-language-server = {
          binary = {
            path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
            arguments = [ "--stdio" ];
          };
          settings.yaml = {
            format.enable = true;
            schemaStore.enable = true;
          };
        };
        gopls = {
          binary = {
            path = "${pkgs.gopls}/bin/gopls";
            arguments = [ ];
          };
          initialization_options.staticcheck = true;
        };
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };
    };

    # Keep Helix's built-in selection and leader bindings intact.
    userKeymaps = [
      {
        context = "Editor && (vim_mode == helix_normal || vim_mode == helix_select) && !menu";
        bindings = paneNavigation // {
          "0" = "vim::StartOfLine";
          "$" = "vim::EndOfLine";
          "g a" = "editor::ToggleCodeActions";
          "space o" = "file_finder::Toggle";
          "space t i" = "editor::ToggleInlayHints";
          "space u w" = "editor::ToggleSoftWrap";
        };
      }
      {
        context = "Editor && vim_mode == helix_normal && !menu";
        bindings.enter = "vim::HelixJumpToWord";
      }
      {
        context = "Editor && vim_mode == insert";
        bindings."j k" = "vim::NormalBefore";
      }
      {
        context = "Workspace";
        bindings."ctrl-\\" = "terminal_panel::ToggleFocus";
      }
      {
        context = "Terminal";
        bindings = paneNavigation;
      }
    ];
  };
}
