{
  pkgs,
  lib,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "lua"
      "basher"
      "modest-dark"
    ];
    extraPackages = [ pkgs.nixd ];

    userSettings = {
      helix_mode = true;
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
        enabled = true;
      };
      inactive_opacity = "0.5";
      auto_install_extensions = true;

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
        nix = {
          binary = {
            path_lookup = true;
          };
        };

        settings = {
          # This is for other LSP servers, keep it separate
          dialyzerEnabled = true;
        };
      };
    };

    userKeymaps = [
      {
        context = "Editor && (vim_mode == normal || vim_mode == visual)";
        bindings = {
          "space g h d" = "editor::ToggleHunkDiff";
          "space g h r" = "editor::RevertSelectedHunks";
          "space t i" = "editor::ToggleInlayHints";
          "space u w" = "editor::ToggleSoftWrap";
          "space c z" = "workspace::ToggleCenteredLayout";
          "space m p" = "markdown::OpenPreview";
          "space m P" = "markdown::OpenPreviewToTheSide";
          "space f p" = "projects::OpenRecent";
          "space f m" = "editor::Format";
          "space f M" = "editor::FormatSelections";
          "space s w" = "pane::DeploySearch";
          "space a c" = "assistant::ToggleFocus";
          "g f" = "editor::OpenExcerpts";
        };
      }
      {
        context = "Editor && vim_mode == normal && !VimWaiting && !menu";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "space c a" = "editor::ToggleCodeActions";
          "space ." = "editor::ToggleCodeActions";
          "space c r" = "editor::Rename";
          "g d" = "editor::GoToDefinition";
          "g D" = "editor::GoToDefinitionSplit";
          "g i" = "editor::GoToImplementation";
          "g I" = "editor::GoToImplementationSplit";
          "g t" = "editor::GoToTypeDefinition";
          "g T" = "editor::GoToTypeDefinitionSplit";
          "g r" = "editor::FindAllReferences";
          "] d" = "editor::GoToDiagnostic";
          "[ d" = "editor::GoToPrevDiagnostic";
          # TODO: Go to next/prev error
          "] e" = "editor::GoToDiagnostic";
          "[ e" = "editor::GoToPrevDiagnostic";
          # Symbol search
          "s s" = "outline::Toggle";
          "s S" = "project_symbols::Toggle";
          # Diagnostic
          "space x x" = "diagnostics::Deploy";

          # +Git
          # Git prev/next hunk
          "] h" = "editor::GoToHunk";
          "[ h" = "editor::GoToPrevHunk";

          # Buffers
          # Switch between buffers
          "shift-h" = "pane::ActivatePrevItem";
          "shift-l" = "pane::ActivateNextItem";
          # Close active panel
          "shift-q" = "pane::CloseActiveItem";
          "ctrl-q" = "pane::CloseActiveItem";
          "space b d" = "pane::CloseActiveItem";
          # Close other items
          "space b o" = "pane::CloseInactiveItems";
          # Save file
          "ctrl-s" = "workspace::Save";
          # File finder
          "space space" = "file_finder::Toggle";
          # Project search
          "space /" = "pane::DeploySearch";
          # TODO: Open other files
          # Show project panel with current file
          "space e" = "pane::RevealInProjectPanel";
        };
      }
      {
        context = "EmptyPane || SharedScreen";
        bindings = {
          # Open file finder
          "space space" = "file_finder::Toggle";
          # Open recent projects
          "space f p" = "projects::OpenRecent";
        };
      }
      {
        context = "Editor && vim_mode == visual && !VimWaiting && !menu";
        bindings = {
          "g c" = "editor::ToggleComments";
        };
      }
      # Better escape
      {
        context = "Editor && vim_mode == insert && !menu";
        bindings = {
          "j j" = "vim::NormalBefore"; # remap jj in insert mode to escape
          "j k" = "vim::NormalBefore"; # remap jk in insert mode to escape
        };
      }
      # Rename
      {
        context = "Editor && vim_operator == c";
        bindings = {
          "c" = "vim::CurrentLine";
          "a" = "editor::ToggleCodeActions"; # zed specific
        };
      }
      # Toggle Terminal
      {
        context = "Workspace";
        bindings = {
          "ctrl-\\" = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "Terminal";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      # File panel (netrw)
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "a" = "project_panel::NewFile";
          "A" = "project_panel::NewDirectory";
          "r" = "project_panel::Rename";
          "d" = "project_panel::Delete";
          "x" = "project_panel::Cut";
          "c" = "project_panel::Copy";
          "p" = "project_panel::Paste";
          # Close project panel as project file panel on the right
          "q" = "workspace::ToggleRightDock";
          "space e" = "workspace::ToggleRightDock";
          # Navigate between panel
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      # Panel navigation
      {
        context = "Dock";
        bindings = {
          "ctrl-w h" = "workspace::ActivatePaneLeft";
          "ctrl-w l" = "workspace::ActivatePaneRight";
          "ctrl-w k" = "workspace::ActivatePaneUp";
          "ctrl-w j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "Workspace";
        bindings = {
          "ctrl-b" = "workspace::ToggleRightDock";
        };
      }
    ];
  };
}
