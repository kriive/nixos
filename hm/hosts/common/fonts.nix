{ pkgs, inputs, ... }:

let
  tx-02 = pkgs.stdenvNoCC.mkDerivation {
    pname = "tx-02";
    version = "2.002";

    src = inputs.tx02-fonts;

    dontPatch = true;
    dontConfigure = true;
    dontBuild = true;
    doCheck = false;
    dontFixup = true;

    installPhase = ''
      runHook preInstall
      install -Dm644 -t $out/share/fonts/opentype/ *.otf
      runHook postInstall
    '';
  };
in
{
  home.packages = with pkgs; [
    tx-02
  ];
}
