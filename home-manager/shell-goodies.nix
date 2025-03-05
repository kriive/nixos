{ inputs, pkgs, ... }:

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
      language = [{ name = "nix"; formatter = { command = "nixfmt"; }; }];
    };
    settings = {
      theme = "base16_transparent";
      editor = {
        true-color = true;
        color-modes = true;
        idle-timeout = 75;
        indent-guides.render = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        soft-wrap.enable = true;
      };

      keys.normal = {
        g = { a = "code_action"; };
        "0" = "goto_line_start";
        "$" = "goto_line_end";
      };

      keys.select = {
        "0" = "goto_line_start";
        "$" = "goto_line_end";
      };

      keys.insert = { j = { k = "normal_mode"; }; };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
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
    ];
  };

  home.packages = with pkgs; [
    eza
    bat
    fastfetch
    htop
    btop
    ripgrep
    nixfmt-rfc-style
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
}
