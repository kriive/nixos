{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "sway/workspaces" ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "tray"
          "idle_inhibitor"
          "network"
          "battery"
          "clock"
          "custom/power"
        ];
        "sway/window" = {
          max-length = 50;
        };
        network = {
          format = "{ifname}";
          format-wifi = "{icon}";
          format-ethernet = "󰈀";
          format-disconnected = "";
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) {icon} - {ipaddr}/{cidr}";
          tooltip-format-ethernet = "{ifname}  - {ipaddr}/{cidr}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "footclient -e 'nmtui-connect'";
          max-length = 50;
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
        };
        battery = {
          format = "{icon}";
          tooltip-format = "{capacity}%";
          format-warning = "{icon}󰈅";
          format-critical = "{icon}󰈅";
          format-icons = {
            charging = [
              "󰢟"
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          states = {
            critical = 15;
            warning = 30;
          };
        };
        clock = {
          interval = 30;
          format = "{:%H:%M}";
          max-length = 25;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            deactivated = "";
            activated = "";
          };
          tooltip = false;
        };
        "custom/power" = {
          format = "";
          on-click = "${pkgs.wlogout}/bin/wlogout";
        };
        tray = {
          icon-size = 15;
          spacing = 10;
        };
      };
    };
    style = ''
          /*
       *colors:
        # Default colors
        primary:
          background: '0x111416'
          foreground: '0xeeeeec'

        # Normal colors
        normal:
          black:   '0x000000'
          red:     '0xcd0000'
          green:   '0x00cd00'
          yellow:  '0xcdcd00'
          blue:    '0x1093f5'
          magenta: '0xcd00cd'
          cyan:    '0x00cdcd'
          white:   '0xfaebd7'

        # Bright colors
        bright:
          black:   '0x404040'
          red:     '0xff0000'
          green:   '0x00ff00'
          yellow:  '0xffff00'
          blue:    '0x11b5f6'
          magenta: '0xff00ff'
          cyan:    '0x00ffff'
          white:   '0xffffff'
       */
      @define-color background #0d1014;
      @define-color foreground #eeeeec;

      @define-color bright-black #404040;
      @define-color bright-red #ff0000;
      @define-color bright-green #00ff00;
      @define-color bright-yellow #ffff00;
      @define-color bright-blue #11b5f6;
      @define-color bright-magenta #ff00ff;
      @define-color bright-white #ffffff;
      @define-color bright-cyan #00ffff;

      @define-color normal-black #000000;
      @define-color normal-red #cd0000;
      @define-color normal-green #00cd00;
      @define-color normal-yellow #cdcd00;
      @define-color normal-blue #1093f5;
      @define-color normal-magenta #cd00cd;
      @define-color normal-white #faebd7;
      @define-color normal-cyan #00cdcd;

      * {
          border: none;
          font-family: JetBrainsMono Nerd Font, Symbols Nerd Font, Iosevka Nerd Font, Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
          min-height: 0;
      }

      box {
        min-height: 35px;
        margin: 0 5px;
      }

      window#waybar {
        background: @background;
      }

      tooltip {
        background: @background;
        color: @foreground;
      }

      #tray menu {
        background: @background;
        color: @foreground;
      }

      #window {
        color: @foreground;
      }

      tooltip label {
        color: white;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: @bright-black;
      }

      #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          color: @foreground;
      }

      #workspaces button.focused {
          color: @foreground;
      }

      #clock, #battery, #custom-power, #idle_inhibitor, #tray, #network {
        padding: 0 10px;
        color: @foreground;
      }

      #custom-power {
        color: @normal-yellow;
      }

      #battery.charging {
          color: @normal-green;
      }

      @keyframes blink {
          to {
              color: @foreground;
          }
      }

      #battery.warning:not(.charging) {
          color: @bright-yellow;
      }

      #battery.critical:not(.charging) {
          color: #f53c3c;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
    '';
  };
}
