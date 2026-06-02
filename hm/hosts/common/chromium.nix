{ ... }:

{
  programs.chromium = {
    enable = true;
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
