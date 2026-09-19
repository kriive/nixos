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
  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    mouse = true;
    keyMode = "vi";
    prefix = "C-a";
    extraConfig = ''
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      unbind C-Left
      unbind C-Right

      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D
    '';
    shell = "${pkgs.fish}/bin/fish";
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
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
    settings = {
      theme = "ayu_evolve";
      editor = {
        true-color = true;
        color-modes = true;
        cursorline = true;
        idle-timeout = 75;
        inline-diagnostics.cursor-line = "hint";
        indent-guides.render = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        soft-wrap.enable = true;
        lsp = {
          display-inlay-hints = false;
        };
      };

      keys.normal = {
        g = {
          a = "code_action";
        };
        "0" = "goto_line_start";
        "$" = "goto_line_end";
        "ret" = "goto_word";
        "space" = {
          o = "file_picker_in_current_buffer_directory";
        };
      };

      keys.select = {
        "0" = "goto_line_start";
        "$" = "goto_line_end";
      };

      keys.insert = {
        j = {
          k = "normal_mode";
        };
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      # Use combined git/jj VCS item (tide-item-jj) instead of the git item
      set -U tide_left_prompt_items pwd vcs newline character
      # Colorscheme: Current
      set -U fish_color_normal B3B1AD
      set -U fish_color_command 39BAE6
      set -U fish_color_keyword 39BAE6
      set -U fish_color_quote C2D94C
      set -U fish_color_redirection FFEE99
      set -U fish_color_end F29668
      set -U fish_color_error FF3333
      set -U fish_color_param B3B1AD
      set -U fish_color_comment 626A73
      set -U fish_color_match F07178
      set -U fish_color_selection --background=E6B450
      set -U fish_color_search_match --background=E6B450
      set -U fish_color_history_current --bold
      set -U fish_color_operator E6B450
      set -U fish_color_escape 95E6CB
      set -U fish_color_cwd 59C2FF
      set -U fish_color_cwd_root red
      set -U fish_color_option B3B1AD
      set -U fish_color_valid_path --underline
      set -U fish_color_autosuggestion 4D5566
      set -U fish_color_user brgreen
      set -U fish_color_host normal
      set -U fish_color_host_remote yellow
      set -U fish_color_history_current --bold
      set -U fish_color_status red
      set -U fish_color_cancel --reverse
      set -U fish_pager_color_background
      set -U fish_pager_color_prefix normal --bold --underline
      set -U fish_pager_color_progress brwhite --background=cyan
      set -U fish_pager_color_completion normal
      set -U fish_pager_color_description B3A06D
      set -U fish_pager_color_selected_background --background=E6B450
      set -U fish_pager_color_selected_prefix
      set -U fish_pager_color_selected_completion
      set -U fish_pager_color_selected_description
      set -U fish_pager_color_secondary_prefix
      set -U fish_pager_color_secondary_description
      set -U fish_pager_color_secondary_completion
      set -U fish_pager_color_secondary_background
    '';
    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        inherit (tide) src;
      }
      {
        name = "tide-item-jj";
        src = pkgs.fetchFromGitHub {
          owner = "lucasadelino";
          repo = "tide-item-jj";
          rev = "e1150b7332b85149b468cb10c2844f082f33975b";
          hash = "sha256-vLSrHPoytZ/kXQh0Bp/4AWe8YLlyufRjepfXUAuWCB8=";
        };
      }
    ];
  };

  home.packages = with pkgs; [
    eza
    bat
    fastfetch
    htop
    btop
    ripgrep
    ruff
    nixfmt
    fishPlugins.tide
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

  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "fish";
      mouse_mode = true;
      show_startup_tips = false;
      show_release_notes = false;
      osc8_hyperlinks = true;
    };
    extraConfig = ''
      keybinds {
          shared_except "locked" {
              bind "Alt t" { NewTab; }
              bind "Alt 1" { GoToTab 1; }
              bind "Alt 2" { GoToTab 2; }
              bind "Alt 3" { GoToTab 3; }
              bind "Alt 4" { GoToTab 4; }
              bind "Alt 5" { GoToTab 5; }
              bind "Alt 6" { GoToTab 6; }
              bind "Alt 7" { GoToTab 7; }
              bind "Alt 8" { GoToTab 8; }
              bind "Alt 9" { GoToTab 9; }
              bind "Alt d" { NewPane "Down"; }
              bind "Alt r" { NewPane "Right"; }
              bind "Alt e" { NewPane "Left"; }

              bind "Shift Alt g" { SwitchToMode "Locked"; }
              bind "Shift Alt q" { Quit; }
              bind "Shift Alt p" { SwitchToMode "Pane"; }
              bind "Shift Alt n" { SwitchToMode "Resize"; }
              bind "Shift Alt s" { SwitchToMode "Scroll"; }
              bind "Shift Alt o" { SwitchToMode "Session"; }
              bind "Shift Alt t" { SwitchToMode "Tab"; }
              bind "Shift Alt m" { SwitchToMode "Move"; }
              bind "Shift Alt b" { SwitchToMode "Tmux"; }
              bind "Shift Alt h" { MovePane "Left"; }
              bind "Shift Alt l" { MovePane "Right"; }
              bind "Shift Alt j" { MovePane "Down"; }
              bind "Shift Alt k" { MovePane "Up"; }
              unbind "Ctrl g" "Ctrl q" "Ctrl p" "Ctrl n" "Ctrl s" "Ctrl o" "Ctrl t" "Ctrl h" "Ctrl b"
          }
          locked {
              bind "Shift Alt g" { SwitchToMode "Normal"; }
              unbind "Ctrl g"
          }
          pane {
              bind "Shift Alt p" { SwitchToMode "Normal"; }
              unbind "Ctrl p"
          }
          resize {
              bind "Shift Alt n" { SwitchToMode "Normal"; }
              unbind "Ctrl n"
          }
          move {
              bind "Shift Alt m" { SwitchToMode "Normal"; }
              unbind "Ctrl h"
          }
          tab {
              bind "Shift Alt t" { SwitchToMode "Normal"; }
              unbind "Ctrl t"
          }
          scroll {
              bind "Shift Alt s" { SwitchToMode "Normal"; }
              unbind "Ctrl s"
          }
          session {
              bind "Shift Alt o" { SwitchToMode "Normal"; }
              unbind "Ctrl o"
          }
      }
    '';
  };
}
