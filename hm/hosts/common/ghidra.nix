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

  ghidraHiDpi = pkgs.symlinkJoin {
    name = "ghidra-hidpi-${pkgs.ghidra.version}";
    paths = [ pkgs.ghidra ];

    postBuild = ''
      rm "$out/bin/ghidra"
      install -Dm755 ${ghidraLauncher} "$out/bin/ghidra"

      rm "$out/share/applications/ghidra.desktop"
      ln -s ${ghidraDesktopItem}/share/applications/ghidra.desktop "$out/share/applications/ghidra.desktop"
    '';

    meta = pkgs.ghidra.meta;
  };
in
{
  home.packages = [
    ghidraHiDpi
  ];
}
