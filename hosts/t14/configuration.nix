{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./privilege-hardening.nix
    ./runtime-services.nix
    inputs.nix-mineral.nixosModules.nix-mineral
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.dms.nixosModules.greeter
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  
  niri-flake.cache.enable = true;

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  services.flatpak.enable = true;

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  systemd.user.services.niri-flake-polkit.enable = false;

  # Enable Plymouth.
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };

  documentation.man.enable = true;

  nix.settings.trusted-users = [
    "root"
    "kriive"
  ];
  nix.settings = {
    substituters = [ "https://niri.cachix.org" ];
    trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
  };

  # Use systemd-based initrd, to enable fancy Plymouth stuff.
  boot.initrd.systemd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "btusb.enable_autosuspend=0"
    # This is needed for smooth trackpad.
    "psmouse.synaptics_intertouch=1"
  ];

  # Hide the OS choice for bootloaders.
  # It's still possible to open the bootloader list by pressing any key
  # It will just not appear on screen unless a key is pressed
  boot.loader.timeout = 0;

  networking.hostName = "nix-thinkpad"; # Define your hostname.
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # hardware.graphics.extraPackages = with pkgs; [
  # ];
  hardware.enableRedistributableFirmware = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.upower.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.hardware.bolt.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        enable_thresholds = true;
        start_threshold = 40;
        stop_threshold = 75;
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  users.users.kriive = {
    isNormalUser = true;
    description = "Manuel Romei";
    extraGroups = [
      "networkmanager"
      "wheel"
      # "libvirtd"
      "docker"
    ];
  };

  programs.virt-manager.enable = true;
  programs.seahorse.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.chromium.enableWideVine = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix
    git
    dnsmasq
  ];

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  networking.firewall.enable = true;
  networking.firewall.checkReversePath = "loose";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  nix-mineral = {
    enable = false;

    preset = "maximum";

    extras.system.hardened-malloc = true;
    extras.system.unprivileged-userns = true;
    extras.system.secure-chrony = true;
    extras.misc.usbguard.enable = false;
    extras.network.bluetooth-kmodules = true;
    settings.etc.kicksecure-bluetooth = false;
    settings.network.ip-forwarding = true;
    filesystems.enable = false;
    settings.system.multilib = true;
    extras.network.tcp-window-scaling = true;
  };

  virtualisation.docker = {
    enable = true;
  };

  virtualisation.libvirtd = {
    enable = false;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor = {
      name = "niri";
    };

    # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
    configHome = "/home/kriive";

    # Custom Quickshell Package
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      };
    };
  };
  #environment.etc."libinput/local-overrides.quirks".text = ''
  #  [Touchpad Pressure Override]
  #  MatchUdevType=touchpad
  #  MatchName=*Synaptics TM3512-010*
  #  AttrPressureRange=10:8
  #'';
}
