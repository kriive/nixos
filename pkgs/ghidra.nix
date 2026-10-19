{ pkgs }:
let
  mkDesktopItem =
    executable: desktopName:
    pkgs.makeDesktopItem {
      name = executable;
      exec = executable;
      inherit desktopName;
      icon = "ghidra";
      genericName = "Ghidra Software Reverse Engineering Suite";
      categories = [ "Development" ];
      terminal = false;
      startupWMClass = "ghidra-Ghidra";
    };
  mkLauncher =
    name: javaOptions:
    pkgs.writeShellScript name ''
      exec "${pkgs.ghidra}/lib/ghidra/support/launch.sh" \
        bg jdk Ghidra "" "${javaOptions}" ghidra.GhidraRun "$@"
    '';

  ghidraDesktopItem = mkDesktopItem "ghidra" "Ghidra";
  ghidraNoScaleDesktopItem = mkDesktopItem "ghidra-noscale" "Ghidra (No Scale)";
  ghidraLauncher = mkLauncher "ghidra-hidpi-launcher" "-Dsun.java2d.uiScale=2.5";
  ghidraNoScaleLauncher = mkLauncher "ghidra-noscale-launcher" "";
in
pkgs.symlinkJoin {
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
}
