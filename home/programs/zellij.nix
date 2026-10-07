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
