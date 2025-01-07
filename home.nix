{ pkgs, inputs, ... }:

{
  imports = [
    ./home/waybar.nix
    ./home/foot.nix
    ./home/helix.nix
    ./home/sway.nix
    ./home/tofi.nix
    ./home/mako.nix
    ./home/senpai.nix
  ];

  home.username = "kriive";
  home.homeDirectory = "/home/kriive";

  home.packages = with pkgs; [
    eza
    swayosd
    slurp
    autotiling
    distrobox
    telegram-desktop
    nerd-fonts.jetbrains-mono
    inputs.fish-nixpkgs.legacyPackages."${pkgs.system}".fishPlugins.tide
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };
  home.shellAliases = {
    cat = "bat";
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
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

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = with pkgs.fishPlugins; [{
        name = "tide";
        inherit (tide) src;
      }];
      package = inputs.fish-nixpkgs.legacyPackages."${pkgs.system}".fish;
    };

    bash = { enable = true; };

    wlogout = {
      enable = true;
    };
  };

  services = {
    swayosd.enable = true;
    mpris-proxy.enable = true;
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
