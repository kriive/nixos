{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      # Use combined git/jj VCS item (tide-item-jj) instead of the git item
      set -g tide_left_prompt_items pwd vcs newline character
      # Colorscheme: Current
      set -g fish_color_normal B3B1AD
      set -g fish_color_command 39BAE6
      set -g fish_color_keyword 39BAE6
      set -g fish_color_quote C2D94C
      set -g fish_color_redirection FFEE99
      set -g fish_color_end F29668
      set -g fish_color_error FF3333
      set -g fish_color_param B3B1AD
      set -g fish_color_comment 626A73
      set -g fish_color_match F07178
      set -g fish_color_selection --background=E6B450
      set -g fish_color_search_match --background=E6B450
      set -g fish_color_operator E6B450
      set -g fish_color_escape 95E6CB
      set -g fish_color_cwd 59C2FF
      set -g fish_color_cwd_root red
      set -g fish_color_option B3B1AD
      set -g fish_color_valid_path --underline
      set -g fish_color_autosuggestion 4D5566
      set -g fish_color_user brgreen
      set -g fish_color_host normal
      set -g fish_color_host_remote yellow
      set -g fish_color_history_current --bold
      set -g fish_color_status red
      set -g fish_color_cancel --reverse
      set -g fish_pager_color_background
      set -g fish_pager_color_prefix normal --bold --underline
      set -g fish_pager_color_progress brwhite --background=cyan
      set -g fish_pager_color_completion normal
      set -g fish_pager_color_description B3A06D
      set -g fish_pager_color_selected_background --background=E6B450
      set -g fish_pager_color_selected_prefix
      set -g fish_pager_color_selected_completion
      set -g fish_pager_color_selected_description
      set -g fish_pager_color_secondary_prefix
      set -g fish_pager_color_secondary_description
      set -g fish_pager_color_secondary_completion
      set -g fish_pager_color_secondary_background
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

}
