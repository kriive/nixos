{
  pkgs,
  ...
}:

{
  imports = [
    ../common/base.nix
    ./hardware-configuration.nix
  ];

  systemd.services.battery-charge-thresholds = {
    description = "Apply battery charge thresholds";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udev-settle.service" ];
    wants = [ "systemd-udev-settle.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      start_threshold="/sys/class/power_supply/BAT0/charge_start_threshold"
      stop_threshold="/sys/class/power_supply/BAT0/charge_stop_threshold"

      [ -w "$start_threshold" ] || {
        echo "Missing or unwritable $start_threshold" >&2
        exit 1
      }

      [ -w "$stop_threshold" ] || {
        echo "Missing or unwritable $stop_threshold" >&2
        exit 1
      }

      echo 40 > "$start_threshold"
      echo 75 > "$stop_threshold"
    '';
  };

  nix-mineral.enable = true;
  nix-mineral.settings.kernel.amd-iommu-force-isolation = false;
  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      };
    };
  };
  #environment.etc."libinput/local-overrides.quirks".text = ''
  #  [Touchpad Pressure Override]
  #  MatchUdevType=touchpad
  #  MatchName=*Synaptics TM3512-010*
  #  AttrPressureRange=10:8
  #'';
}
