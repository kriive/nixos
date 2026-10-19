{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.danksearch.homeModules.dsearch
    ./dms/settings.nix
  ];

  programs.dsearch.enable = true;

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;

    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };
}
