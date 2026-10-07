{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,UseMultiPlaneFormatForHardwareVideo,TouchpadOverscrollHistoryNavigation"
      "--ozone-platform-hint=auto"
    ];
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }
      { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; }
    ];
  };
}
