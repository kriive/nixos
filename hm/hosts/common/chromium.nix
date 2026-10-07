{ pkgs, ... }:

let
  # Temporary workaround for https://issues.chromium.org/issues/486362478.
  # Like the Incus qemu-img wrapper, hide the system allocator preload in a
  # mount namespace, while keeping the rest of /etc available to the browser.
  chromiumLauncher = pkgs.writeShellScript "chromium-without-hardened-malloc" ''
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
  chromiumWithoutHardenedMalloc = pkgs.chromium.overrideAttrs (old: {
    buildCommand = old.buildCommand + ''
      mv "$out/bin/chromium" "$out/bin/.chromium-unwrapped"
      makeWrapper ${chromiumLauncher} "$out/bin/chromium" \
        --add-flags "$out/bin/.chromium-unwrapped"
    '';
  });
in
{
  programs.chromium = {
    enable = true;
    package = chromiumWithoutHardenedMalloc;
    commandLineArgs = [
      #   "--use-gl=angle"
      #   "--use-angle=vulkan"
      "--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,UseMultiPlaneFormatForHardwareVideo,TouchpadOverscrollHistoryNavigation"
      "--ozone-platform-hint=auto"
      # "--disable-pinch"
    ];
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }
      { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; }
    ];
  };
}
