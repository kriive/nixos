{
  pkgs,
  inputs,
  hostName,
  lib,
  ...
}:

{
  imports = [
    ./ghidra.nix
    ./shell-goodies.nix
    ./foot.nix
    ./fonts.nix
    ./zathura.nix
    ./mpv.nix
    ./imv.nix
    ./niri.nix
    ./opencode.nix
    ./rbw.nix
    ./go-librespot.nix
    ./spotify-player.nix
    ./vesktop.nix
    ./zed.nix
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.danksearch.homeModules.dsearch
    inputs.hunk.homeManagerModules.default
  ];

  programs.niri = {
    package = pkgs.niri-unstable;
  };

  programs.git.enable = true;

  programs.dsearch.enable = true;

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
    };

    niri = {
      enableSpawn = false;
      enableKeybinds = false;
      includes = {
        enable = true;
      };
    };

    settings = import ./dms;

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)

    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };

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
    gtk4.theme = null;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };

  services.gammastep = {
    enable = true;

    # Coordinates based location
    provider = "manual";

    latitude = "44.8";
    longitude = "10.33";
  };

  programs.hunk = {
    enable = true;
    enableGitIntegration = true; # Optional: set hunk as default git pager
    settings = {
      theme = "graphite";
      mode = "split";
      line_numbers = true;
    };
  };

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";

  home.shellAliases = {
    k = "kubecolor";
  };

  home.packages = with pkgs; [
    adw-gtk3
    telegram-desktop
    ioskeley-mono.normal-term-NF
    wineWow64Packages.waylandFull
    winetricks
    delfin
    unzip
    zip
    p7zip
    ethtool
    inputs.codex.packages.${pkgs.stdenv.hostPlatform.system}.default
    dig
    mtr
    jujutsu
    kubectl
  ];

  programs = {
    chromium = {
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
    kubecolor = {
      enable = true;
      enableAlias = true;
    };
  };

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
