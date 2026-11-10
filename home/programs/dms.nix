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

    # DMS embeds dux-qt-base, a Quickshell fork that already contains the QML
    # disk-cache fix (upstream PR #1049). Only the local scanner optimisation
    # is still applied, on top of the runtime the flake pins.
    duxQtBase.package = (inputs.dms.lib.buildDmsPkgs pkgs).dux-qt-base.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [ ../../pkgs/patches/dux-qt-base-fast-scan.patch ];
    });

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
  };
}
