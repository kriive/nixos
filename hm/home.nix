{ pkgs, inputs, ... }:

{
  imports = [
    ./shell-goodies.nix
    ./foot.nix
    ./zathura.nix
    ./mpv.nix
    ./imv.nix
  ];

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };
  
  home.username = "kriive";
  home.homeDirectory = "/home/kriive";

  home.packages = with pkgs; [
    adw-gtk3
    telegram-desktop
    nerd-fonts.jetbrains-mono
    wineWowPackages.waylandFull
    ghidra
    delfin
  ];

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [
      #   "--use-gl=angle"
      #   "--use-angle=vulkan"
      #   "--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,UseMultiPlaneFormatForHardwareVideo,TouchpadOverscrollHistoryNavigation"
        "--ozone-platform-hint=auto"
      ];
      extensions = [
        { id = "nngceckbapebfimnlniiiahkandclblb"; }
        { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }
        { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; }
     ];
    };
  };


  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
