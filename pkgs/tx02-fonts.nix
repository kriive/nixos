{
  lib,
  stdenvNoCC,
  requireFile,
}:
stdenvNoCC.mkDerivation {
  pname = "tx-02";
  version = "2.002";

  src = requireFile {
    # Match the existing content-addressed source, independently of its original directory.
    name = "source";
    hashMode = "recursive";
    hash = "sha256-XBEhaNYnYmQWhgazM963hYsy+VN7HNV7Z2UTcz/WFnk=";
    message = ''
      TX-02 is a private font. Add your licensed TX-02 2.002 directory to the store:
        nix store add --mode nar --name source /path/to/tx-02
      The directory must match the hash in pkgs/tx02-fonts.nix.
      See README.md for setup instructions. Do not commit the font files.
    '';
  };
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
  meta.license = lib.licenses.unfree;
}
