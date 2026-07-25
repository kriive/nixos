{
  hostName,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.danksearch.homeModules.dsearch
  ];

  programs.dsearch.enable = true;

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    niri = {
      enableSpawn = false;
      enableKeybinds = false;
      includes.enable = true;
    };

    settings =
      import ./dms
      // lib.optionalAttrs (hostName == "t14") {
        acProfileName = "";
        batteryAutoPowerSaver = true;
        batteryLockTimeout = 600;
        batteryLowThreshold = 20;
        batteryMonitorTimeout = 300;
        batteryProfileName = "";
        batterySuspendTimeout = 1800;
        lockBeforeSuspend = true;
      };

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;

    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };
}
