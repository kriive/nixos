{ config, ... }:
{
  systemd.services.power-profiles-daemon-settings = {
    description = "Configure power-profiles-daemon actions";
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

  systemd.timers.power-profiles-daemon-settings = {
    description = "Configure power-profiles-daemon actions after boot";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "30s";
      AccuracySec = "1s";
    };
  };

  # Keep the system awake with the lid closed while using a powered dock.
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";

}
