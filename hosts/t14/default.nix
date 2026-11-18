{
  lib,
  pkgs,
  utils,
  ...
}:
let
  hdaControl = "/dev/snd/by-path/pci-0000:07:00.6";
  micControl = "/dev/snd/by-path/pci-0000:07:00.5-platform-acp_pdm_mach.0";
  audioDevices = map (path: "${utils.escapeSystemdPath path}.device") [
    hdaControl
    micControl
  ];
in
{
  imports = [
    ../../nixos/base.nix
    ../../nixos/laptop.nix
    ../../nixos/desktop.nix
    ../../nixos/docker.nix
    ../../nixos/hardening.nix
    ../../nixos/virtualization/tools.nix
    ../../nixos/virtualization/libvirt.nix
    ./hardware-configuration.nix
    ./power.nix
    ./touchpad.nix
    ./fingerprint.nix
  ];

  system.stateVersion = "25.11";

  boot.kernelModules = [ "snd_ctl_led" ];
  systemd.services.thinkpad-mic-led = {
    description = "Initialize the ThinkPad microphone mute LED";
    wantedBy = [ "multi-user.target" ];
    requires = audioDevices;
    after = audioDevices ++ [ "systemd-modules-load.service" ];
    before = [ "systemd-user-sessions.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      card=$(readlink -e ${hdaControl})
      # ALSA's fixed boot sequence creates the ACP mic switch and attaches the LED.
      exec ${lib.getExe' pkgs.alsa-utils "alsaucm"} -c "hw:''${card##*/controlC}" set _fboot ""
    '';
  };

  home-manager.users.kriive.imports = [
    ../../home/kriive.nix
    ./home.nix
  ];
  boot.initrd.luks.devices."luks-a36cdc1c-1230-4c91-9ad8-123d54c26969".crypttabExtraOpts = [
    "tpm2-device=auto"
  ];
  nix-mineral.settings.kernel.amd-iommu-force-isolation = false;
  nix-mineral.settings.kernel.intel-iommu = false;
}
