{ lib, pkgs, ... }:
let
  # GLib built against glibc >= 2.43 uses free_sized(). Chromium/Electron may
  # redirect malloc/free to PartitionAlloc without exporting free_sized().
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

  wrapApplication = executable: package:
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
        '' + lib.optionalString (executable == "chromium") ''
          rm -f "$out/bin/chromium-browser"
          ln -s chromium "$out/bin/chromium-browser"
        '';
      };
    in
    # Home Manager invokes .override on both programs to apply command-line
    # flags and Vesktop's withSystemVencord option. Keep those overrides working.
    wrapped // {
      override = args: wrapApplication executable (package.override args);
    };
in
{
  programs.chromium.package = wrapApplication "chromium" pkgs.chromium;
  programs.vesktop.package = wrapApplication "vesktop" pkgs.vesktop;
}
