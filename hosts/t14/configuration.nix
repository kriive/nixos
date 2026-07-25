{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../common/base.nix
    ./hardware-configuration.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "pnpm-10.29.2"
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

  systemd.services.power-profiles-daemon-settings = {
    description = "Configure power-profiles-daemon actions";
    wantedBy = [ "graphical.target" ];
    after = [ "power-profiles-daemon.service" ];
    requires = [ "power-profiles-daemon.service" ];
    script = ''
      powerprofilesctl="${config.services.power-profiles-daemon.package}/bin/powerprofilesctl"

      if ! "$powerprofilesctl" query-battery-aware | grep -q "True$"; then
        "$powerprofilesctl" configure-battery-aware --enable
      fi

      enable_action() {
        action="$1"

        if ! "$powerprofilesctl" list-actions \
          | grep -A2 -F "Name: $action" \
          | grep -q "Enabled: True"; then
          "$powerprofilesctl" configure-action "$action" --enable
        fi
      }

      enable_action amdgpu_dpm
      enable_action amdgpu_panel_power
    '';
    serviceConfig.Type = "oneshot";
  };

  boot.initrd.kernelModules = [ "rmi_smbus" ];

  boot.initrd.luks.devices."luks-a36cdc1c-1230-4c91-9ad8-123d54c26969".crypttabExtraOpts = [
    "tpm2-device=auto"
  ];
  nix-mineral.enable = true;
  nix-mineral.settings.kernel.amd-iommu-force-isolation = false;
  nix-mineral.settings.kernel.intel-iommu = false;

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
}
