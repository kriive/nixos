{
  config,
  lib,
  pkgs,
  ...
}:
let
  converter = pkgs.fetchzip {
    url = "https://codeload.github.com/antoinecellerier/speaker-tuning-to-easyeffects/tar.gz/9c25b9b1bb1e25110352719ea4c4b6c3fa61e20d";
    extension = "tar.gz";
    hash = "sha256-PyOFrOp3DMBJWY7aImv2WpZkrw/7ookGY2IgfK5sTcc=";
  };
  driver = pkgs.fetchurl {
    url = "https://download.lenovo.com/pccbbs/mobiles/r1mra06w.exe";
    hash = "sha256-5r1tqWTPMBoMkc5C7wQ2zmZDVyg3fCLxK4V0Ol6GD/A=";
  };
  speaker = "alsa_output.pci-0000_07_00.6.HiFi__Speaker__sink";
  presets =
    pkgs.runCommand "t14-dolby-speaker-presets"
      {
        nativeBuildInputs = [
          pkgs.innoextract
          (pkgs.python3.withPackages (ps: [
            ps.numpy
            ps.scipy
          ]))
        ];
      }
      ''
        tuningFile=DEV_0257_SUBSYS_17AA5094_PCI_SUBSYS_509417AA.xml
        innoextract --silent --include "$tuningFile" --output-dir driver ${driver}
        tuning=$(find driver -type f -name "$tuningFile")
        test -f "$tuning"
        python3 ${converter}/dolby_to_easyeffects.py "$tuning" \
          --output-dir "$out/output" --irs-dir "$out/irs" --no-reload

        PYTHONPATH=${converter} python3 - <<'PY'
        import os
        from pathlib import Path
        from lib.preset.autoload import write_autoload, write_bypass_preset

        out = Path(os.environ["out"])
        write_autoload(out / "autoload/output", "${speaker}",
                       "Ryzen HD Audio Controller Speaker", "Speaker", "Dolby-Balanced")
        write_bypass_preset(out / "output", "Nothing")
        PY

        # Match the Git checkout's version stamp so Home Manager can adopt the original files.
        sed -i 's/v2026\.10\.1-24-g9c25b9b1/v2026.10.1-24-g9c25b9b/' "$out"/output/*.json
      '';
  dataDir = "${config.xdg.dataHome}/easyeffects";
  settings = "${config.xdg.configHome}/easyeffects/db/easyeffectsrc";
  writeConfig = lib.getExe' pkgs.kdePackages.kconfig "kwriteconfig6";
  playerctl = lib.getExe pkgs.playerctl;
in
{
  services.easyeffects.enable = true;

  programs.niri.settings.binds = {
    XF86AudioMicMute = {
      repeat = false;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mic"
        "mute"
      ];
    };
    XF86NotificationCenter = {
      repeat = false;
      action.spawn = [
        playerctl
        "previous"
      ];
    };
    XF86PickupPhone = {
      repeat = false;
      action.spawn = [
        playerctl
        "play-pause"
      ];
    };
    XF86HangupPhone = {
      repeat = false;
      action.spawn = [
        playerctl
        "next"
      ];
    };
  };

  xdg.dataFile.easyeffects = {
    source = presets;
    recursive = true;
  };

  home.activation.configureThinkPadSpeakerPreset =
    lib.hm.dag.entryBetween [ "reloadSystemd" ] [ "linkGeneration" ]
      ''
        # Home Manager leaves identical pre-existing files in place. Adopt those files as links.
        presetLinks="$(readlink -e "$newGenPath/home-files")"/${lib.escapeShellArg (lib.removePrefix "${config.home.homeDirectory}/" dataDir)}
        for source in "$presetLinks"/{autoload/output,irs,output}/*; do
          target=${lib.escapeShellArg dataDir}/"''${source#"$presetLinks/"}"
          if [[ -f "$target" && ! -L "$target" ]] && cmp -s "$source" "$target"; then
            run ln -Tsf -- "$source" "$target"
          fi
        done

        run ${writeConfig} --file ${lib.escapeShellArg settings} --group Window \
          --key outputAutoloadingFallbackPreset Nothing
        run ${writeConfig} --file ${lib.escapeShellArg settings} --group Window \
          --key outputAutoloadingUsesFallback --type bool true
      '';

  programs.dank-material-shell.settings = {
    # Let power-profiles-daemon handle AC/battery profile selection on the T14.
    acProfileName = "";
    batteryProfileName = "";
    batteryLowThreshold = 20;
  };
}
