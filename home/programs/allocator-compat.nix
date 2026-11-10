{ lib, pkgs, ... }:
let
  # GLib built against glibc >= 2.43 uses free_sized(). Chromium/Electron apps
  # may redirect malloc/free to PartitionAlloc without exporting free_sized().
  freeSizedCompat = pkgs.runCommandCC "free-sized-compat" { } ''
    mkdir -p "$out/lib"
    cat > compat.c <<'EOF'
    #include <stddef.h>
    #include <stdlib.h>

    void free_sized(void *ptr, size_t size) {
      (void)size;
      free(ptr);
    }

    void free_aligned_sized(void *ptr, size_t alignment, size_t size) {
      (void)alignment;
      (void)size;
      free(ptr);
    }
    EOF
    $CC -O2 -fPIC -shared -fno-builtin-free \
      -Wl,-soname,libfree-sized-compat.so \
      -o "$out/lib/libfree-sized-compat.so" compat.c
  '';

  preload = lib.concatStringsSep ":" [
    "${freeSizedCompat}/lib/libfree-sized-compat.so"
    "${pkgs.graphene-hardened-malloc}/lib/libhardened_malloc.so"
  ];

  # The custom wrappers replace `.override`, which would hide the signature of
  # the package they wrap. Restore it: Home Manager no longer assumes that any
  # package can be reconfigured, it probes `lib.functionArgs package.override`
  # for a `cfg` argument and otherwise drops `policies`, `pkcs11Modules` and
  # `configPath` with "cannot be reconfigured" warning. `lib.setFunctionArgs`
  # only sets metadata, so `.override` stays callable with an attribute set
  # (Chromium's command-line flags, Vesktop's withSystemVencord) as well as with
  # the `old: ...` function form used by the Firefox module.
  rewrap =
    wrap: executable: package: wrapped:
    wrapped
    // {
      override = lib.setFunctionArgs (args: wrap executable (package.override args)) (
        lib.functionArgs package.override
      );
    };

  wrapApplication =
    executable: package:
    let
      wrapped = pkgs.symlinkJoin {
        name = "${package.name}-allocator-compat";
        paths = [ package ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        inherit (package) meta;

        postBuild = ''
          rm "$out/bin/${executable}"
          makeWrapper "${package}/bin/${executable}" "$out/bin/${executable}" \
            --set LD_PRELOAD "${preload}"
        ''
        + lib.optionalString (executable == "chromium") ''
          rm -f "$out/bin/chromium-browser"
          ln -s chromium "$out/bin/chromium-browser"
        '';
      };
    in
    # Home Manager invokes .override on both programs to apply command-line
    # flags and Vesktop's withSystemVencord option. Keep those overrides working.
    rewrap wrapApplication executable package wrapped;

  # Firefox bundles mozjemalloc, which is incompatible with hardened malloc.
  # glibc reads the system allocator from /etc/ld-nix.so.preload on every exec,
  # so hide that file from Firefox with a mount namespace. The preload list is
  # a symlink into the Nix store, which bubblewrap refuses to mount over, so
  # resolve it first.
  wrapWithoutHardenedMalloc =
    executable: package:
    let
      launcher = pkgs.writeShellScript "${executable}-no-hardened-malloc" ''
        preload=$(${pkgs.coreutils}/bin/readlink -f /etc/ld-nix.so.preload)
        if [ -r "$preload" ]; then
          exec ${pkgs.bubblewrap}/bin/bwrap \
            --dev-bind / / \
            --ro-bind ${pkgs.emptyFile} "$preload" \
            ${package}/bin/${executable} "$@"
        fi
        exec ${package}/bin/${executable} "$@"
      '';

      wrapped = pkgs.symlinkJoin {
        name = "${package.name}-no-hardened-malloc";
        paths = [ package ];
        inherit (package) meta version;

        postBuild = ''
          rm "$out/bin/${executable}"
          ln -s ${launcher} "$out/bin/${executable}"
        '';
      };
    in
    rewrap wrapWithoutHardenedMalloc executable package wrapped;
in
{
  programs.chromium.package = wrapApplication "chromium" pkgs.chromium;
  programs.firefox.package = wrapWithoutHardenedMalloc "firefox" pkgs.firefox;
  programs.vesktop.package = wrapApplication "vesktop" pkgs.vesktop;
  home.packages = [ (wrapApplication "signal-desktop" pkgs.signal-desktop) ];
}
