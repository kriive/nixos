{
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
      keybinds preset="unlock-first" {
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
          }
      }
    '';
  };
}
