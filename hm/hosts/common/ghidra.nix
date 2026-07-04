{ pkgs, ... }:

let
  ghidraUiScale = "2.5";

  ghidraDesktopItem = pkgs.makeDesktopItem {
    name = "ghidra";
    exec = "ghidra";
    icon = "ghidra";
    desktopName = "Ghidra";
    genericName = "Ghidra Software Reverse Engineering Suite";
    categories = [ "Development" ];
    terminal = false;
    startupWMClass = "ghidra-Ghidra";
  };

  ghidraNoScaleDesktopItem = pkgs.makeDesktopItem {
    name = "ghidra-noscale";
    exec = "ghidra-noscale";
    icon = "ghidra";
    desktopName = "Ghidra (No Scale)";
    genericName = "Ghidra Software Reverse Engineering Suite";
    categories = [ "Development" ];
    terminal = false;
    startupWMClass = "ghidra-Ghidra";
  };

  ghidraLauncher = pkgs.writeShellScript "ghidra-hidpi-launcher" ''
    exec "${pkgs.ghidra}/lib/ghidra/support/launch.sh" \
      bg \
      jdk \
      Ghidra \
      "" \
      "-Dsun.java2d.uiScale=${ghidraUiScale}" \
      ghidra.GhidraRun \
      "$@"
  '';

  ghidraNoScaleLauncher = pkgs.writeShellScript "ghidra-noscale-launcher" ''
    exec "${pkgs.ghidra}/lib/ghidra/support/launch.sh" \
      bg \
      jdk \
      Ghidra \
      "" \
      "" \
      ghidra.GhidraRun \
      "$@"
  '';

  ghidraHiDpi = pkgs.symlinkJoin {
    name = "ghidra-hidpi-${pkgs.ghidra.version}";
    paths = [ pkgs.ghidra ];

    postBuild = ''
      rm "$out/bin/ghidra"
      install -Dm755 ${ghidraLauncher} "$out/bin/ghidra"
      install -Dm755 ${ghidraNoScaleLauncher} "$out/bin/ghidra-noscale"

      rm "$out/share/applications/ghidra.desktop"
      ln -s ${ghidraDesktopItem}/share/applications/ghidra.desktop "$out/share/applications/ghidra.desktop"
      ln -s ${ghidraNoScaleDesktopItem}/share/applications/ghidra-noscale.desktop "$out/share/applications/ghidra-noscale.desktop"
    '';

    meta = pkgs.ghidra.meta;
  };
in
{
  home.packages = [
    ghidraHiDpi
  ];
}
