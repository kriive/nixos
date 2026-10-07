{
  pkgs,
  src,
  pwnActivation,
}:
{
  formatting = pkgs.runCommand "nix-formatting" { nativeBuildInputs = [ pkgs.nixfmt ]; } ''
    find ${src} -type f -name '*.nix' -print0 | xargs -0 nixfmt --check
    touch $out
  '';
  lint =
    pkgs.runCommand "nix-lint"
      {
        nativeBuildInputs = [
          pkgs.statix
          pkgs.deadnix
        ];
      }
      ''
        statix check --config ${src}/statix.toml ${src}
        deadnix --fail ${src}
        touch $out
      '';
  # Flake checking does not otherwise validate standalone Home Manager outputs.
  pwn-home = pwnActivation;
}
