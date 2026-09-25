{ config, ... }:

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

  # Keep the system awake with the lid closed while using a powered dock.
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";

  # Local carry from orospakr/thinkpad-t14-amd-touchpad at 03cdbb1857f5b9a6fbcef52a0f982d56edb99f5f
  # (pristine driver sources: Linux v7.2.3). Revisit when kernel patches land upstream.
  boot.kernelPatches = [
    {
      name = "t14-amd-asf-smbus-host-notify";
      patch = ./kernel-patches/0001-i2c-piix4-add-SMBus-Host-Notify-through-the-ASF-target-block-on-SMB0001-platforms.patch;
    }
    {
      name = "t14-amd-rmi-smbus-resume-settle";
      patch = ./kernel-patches/0002-Input-synaptics-rmi4-let-the-device-settle-after-the-PS2-reset-on-SMBus-resume.patch;
    }
    {
      name = "t14-amd-synaptics-rmi-doze-interval";
      patch = ./kernel-patches/0003-Input-synaptics-set-the-RMI4-doze-interval-Windows-uses-on-affected-ThinkPads.patch;
    }
    {
      name = "t14-amd-synaptics-intertouch-len2073";
      patch = ./kernel-patches/0004-Input-synaptics-enable-InterTouch-on-the-ThinkPad-T14-P14s-Gen-2-AMD.patch;
    }
  ];

  boot.initrd.kernelModules = [ "rmi_smbus" ];

  boot.initrd.luks.devices."luks-a36cdc1c-1230-4c91-9ad8-123d54c26969".crypttabExtraOpts = [
    "tpm2-device=auto"
  ];
  nix-mineral.enable = true;
  nix-mineral.settings.kernel.amd-iommu-force-isolation = false;
  nix-mineral.settings.kernel.intel-iommu = false;
}
