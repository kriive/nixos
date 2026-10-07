{ pkgs, ... }:

let
  # Temporary workaround for https://issues.chromium.org/issues/486362478,
  # which also affects Electron. Match Chromium's per-app preload isolation.
  vesktopLauncher = pkgs.writeShellScript "vesktop-without-hardened-malloc" ''
    if [ -e /etc/ld-nix.so.preload ]; then
      # NixOS uses a symlink here; bwrap needs the resolved mount destination.
      preload=$(${pkgs.coreutils}/bin/readlink -f /etc/ld-nix.so.preload)
      exec ${pkgs.bubblewrap}/bin/bwrap \
        --dev-bind / / \
        --ro-bind /dev/null "$preload" \
        "$@"
    fi

    exec "$@"
  '';
  # Home Manager overrides withSystemVencord when installing the package.
  # Forward package overrides to Vesktop and wrap the resulting launcher.
  vesktopWithoutHardenedMalloc = pkgs.lib.makeOverridable (
    args:
    let
      vesktop = pkgs.vesktop.override args;
    in
    pkgs.symlinkJoin {
      name = "vesktop-without-hardened-malloc-${vesktop.version}";
      paths = [ vesktop ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        rm "$out/bin/vesktop"
        makeWrapper ${vesktopLauncher} "$out/bin/vesktop" \
          --add-flags "${vesktop}/bin/vesktop"
      '';
      inherit (vesktop) meta;
    }
  ) { };
in
{
  programs.vesktop = {
    enable = true;
    package = vesktopWithoutHardenedMalloc;
  };
}
