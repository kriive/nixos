{ pkgs, lib, ... }:

{
  programs.swaylock.enable = true;
  
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";

      terminal = "footclient";
      defaultWorkspace = "workspace number 1";
      output = {
        "Samsung Electric Company U28E570 HTPKA02864" = { scale = "2"; };

        "*" = { bg = "#111416 solid_color"; };
        # "*" = { bg = "${./files/thinkpad-mountains.jpg} fill"; };
      };

      input = {
        "1739:0:Synaptics_TM3471-020" = {
          tap = "enabled";
          tap_button_map = "lrm";
          dwt = "enabled"; # disable-while-typing enabled
          natural_scroll = "enabled";
          click_method = "clickfinger";
        };

        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
          xkb_options = "compose:menu,level3:ralt_switch";
        };
      };

      startup = [
        { command = "autotiling"; }
        {
          command = "foot --server";
          always = true;
        }
      ];

      bars = [{
        id = "mainBar";
        command = "${pkgs.waybar}/bin/waybar";
      }];

      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
        "XF86AudioLowerVolume" = "exec  swayosd-client --output-volume lower";
        "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
        "XF86AudioMicMute" = "exec swayosd-client --input-volume mute-toggle";
        "--release Caps_Lock" = "exec swayosd-client --caps-lock";
        "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
        "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";
        "${modifier}+space" = "exec tofi-drun | xargs swaymsg exec --";
        "${modifier}+Ctrl+l" = ''
          exec swaylock --color 101415 --indicator-radius 100 --indicator-thickness 7 --indicator-caps-lock --text-ver-color 00000000 --ring-color 404040 --key-hl-color cdcd00 --text-color ffc107 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 "$@"'';
      };
    };

    extraConfig = ''
      default_border pixel 1
      hide_edge_borders smart

      mouse_warping container

      bindswitch --reload --locked lid:on output eDP-1 disable
      bindswitch --reload --locked lid:off output eDP-1 enable

      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
    '';
  };
}
