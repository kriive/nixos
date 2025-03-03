{ pkgs, inputs, ... }:

{
  imports = [
    ../../home-manager/waybar.nix
    ../../home-manager/foot.nix
    ../../home-manager/helix.nix
    ../../home-manager/sway.nix
    ../../home-manager/tofi.nix
    ../../home-manager/mako.nix
    ../../home-manager/fish.nix
    ../../home-manager/zathura.nix
    ../../home-manager/imv.nix
    ../../home-manager/tmux.nix
    ../../home-manager/mpv.nix
    ../../home-manager/gtk.nix
  ];

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";

  home.packages = with pkgs; [
    eza
    bat
    swayosd
    slurp
    autotiling
    telegram-desktop
    fastfetch
    senpai
    ghidra
    htop
    btop
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
    inputs.fish-nixpkgs.legacyPackages."${pkgs.system}".fishPlugins.tide
    inputs.idapro.packages."${pkgs.system}".ida-pro
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  home.shellAliases = {
    cat = "bat";
    ls = "eza";
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [
        "--use-gl=angle"
        "--use-angle=vulkan"
        "--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,UseMultiPlaneFormatForHardwareVideo,TouchpadOverscrollHistoryNavigation"
        "--ozone-platform-hint=auto"
      ];
      extensions = [
        { id = "nngceckbapebfimnlniiiahkandclblb"; }
        { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }
        { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; }
      ];
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    bash = {
      enable = true;
    };

    wlogout = {
      enable = true;
    };
  };

  services = {
    swayosd.enable = true;
    mpris-proxy.enable = true;
    wlsunset = {
      enable = true;
      latitude = "44.801483";
      longitude = "10.327904";
    };
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
