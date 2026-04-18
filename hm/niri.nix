{
  inputs,
  pkgs,
  config,
  ...
}:

{
  programs.niri.settings = {
    input.keyboard.xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "compose:menu,lv3:ralt_switch";
    };
    input.touchpad = {
      tap = true;
      dwt = true;
      natural-scroll = true;
      click-method = "clickfinger";
    };
    input.warp-mouse-to-focus.enable = true;
    hotkey-overlay.skip-at-startup = true;
    prefer-no-csd = true;
    binds = {
      "Super+Return" = {
        action.spawn = [ "footclient" ];
      };
      "Super+C" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "powermenu"
          "toggle"
        ];
      };
      "Super+space" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "spotlight"
          "toggle"
        ];
      };
      "XF86AudioLowerVolume" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "decrement"
          "5"
        ];
      };
      "XF86AudioMute" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "mute"
        ];
      };
      "XF86AudioRaiseVolume" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "increment"
          "5"
        ];
      };
      "Super+1" = {
        action.focus-workspace = 1;
      };
      "Super+2" = {
        action.focus-workspace = 2;
      };
      "Super+3" = {
        action.focus-workspace = 3;
      };
      "Super+4" = {
        action.focus-workspace = 4;
      };
      "Super+5" = {
        action.focus-workspace = 5;
      };
      "Super+6" = {
        action.focus-workspace = 6;
      };
      "Super+7" = {
        action.focus-workspace = 7;
      };
      "Super+8" = {
        action.focus-workspace = 8;
      };
      "Super+9" = {
        action.focus-workspace = 9;
      };
      "Super+I" = {
        action.focus-workspace-up = [ ];
      };
      "Super+U" = {
        action.focus-workspace-down = [ ];
      };
      "Super+Ctrl+I" = {
        action.move-column-to-workspace-up = [ ];
      };
      "Super+Ctrl+U" = {
        action.move-column-to-workspace-down = [ ];
      };
      "Super+H" = {
        action.focus-column-left = [ ];
      };
      "Super+L" = {
        action.focus-column-right = [ ];
      };
      "Super+Ctrl+H" = {
        action.move-column-left = [ ];
      };
      "Super+Ctrl+L" = {
        action.move-column-right = [ ];
      };
      "Super+K" = {
        action.focus-window-up = [ ];
      };
      "Super+J" = {
        action.focus-window-down = [ ];
      };
      "Super+Ctrl+K" = {
        action.move-window-up = [ ];
      };
      "Super+Ctrl+J" = {
        action.move-window-down = [ ];
      };
      "Super+F" = {
        action.maximize-column = [ ];
      };
      "Super+R" = {
        action.switch-preset-column-width = [ ];
      };
      "Super+Q" = {
        action.close-window = [ ];
      };
      "Super+O" = {
        action.toggle-overview = [ ];
      };
      "Super+Minus" = {
        action.set-column-width = "-10%";
      };
      "Super+Equal" = {
        action.set-column-width = "+10%";
      };
      "Super+S" = {
        action.screenshot = [ ];
      };
      "Super+W" = {
        action.screenshot-window = [ ];
      };
      "Super+Shift+S" = {
        action.screenshot-screen = [ ];
      };
      "Super+Shift+H" = {
        action.move-column-to-monitor-left = [];
      };
      "Super+Shift+J" = {
        action.move-column-to-monitor-down = [];
      };
      "Super+Shift+K" = {
        action.move-column-to-monitor-up = [];
      };
      "Super+Shift+L" = {
        action.move-column-to-monitor-right = [];
      };
      "Super+Shift+U" = {
        action.focus-monitor-down = [];
      };
      "Super+Shift+I" = {
        action.focus-monitor-up = [];
      };
    };
  };
}
