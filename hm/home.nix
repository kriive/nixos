{ pkgs, inputs, ... }:

{
  imports = [
    ./shell-goodies.nix
    ./foot.nix
    ./zathura.nix
    ./mpv.nix
    ./imv.nix
    ./niri.nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 32; # Imposta qui la dimensione (es. 24, 32, 48)
  };
  
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };
  
  services.gammastep = {
    enable = true;

    # Coordinates based location
    provider = "manual";

    latitude = "44.8";
    longitude = "10.33";
  };

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";

  home.packages = with pkgs; [
    adw-gtk3
    telegram-desktop
    nerd-fonts.jetbrains-mono
    wineWowPackages.stableFull
    winetricks
    ghidra
    delfin
  ];

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [
      #   "--use-gl=angle"
      #   "--use-angle=vulkan"
        "--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,UseMultiPlaneFormatForHardwareVideo,TouchpadOverscrollHistoryNavigation"
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
