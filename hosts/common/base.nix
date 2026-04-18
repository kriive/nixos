{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./runtime-services.nix
    ./privilege-hardening.nix
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

  # Lanzaboote currently replaces the systemd-boot module.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.timeout = 0;

  nixpkgs = {
    overlays = [ inputs.niri.overlays.niri ];
    config.allowUnfree = true;
    config.chromium.enableWideVine = true;
  };

  systemd.user.services.niri-flake-polkit.enable = false;

  documentation.man.enable = true;

  nix.settings = {
    trusted-users = [
      "root"
      "kriive"
    ];
    substituters = [ "https://niri.cachix.org" ];
    trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
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
    "psmouse.synaptics_intertouch=1"
  ];

  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };

  networking.hostName = "nix-thinkpad";
  networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Rome";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.enableRedistributableFirmware = true;

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

  services.printing.enable = true;
  services.upower.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.hardware.bolt.enable = true;
  services.flatpak.enable = true;
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.fwupd.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  users.users.kriive = {
    isNormalUser = true;
    description = "Manuel Romei";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/kriive";
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };

  programs.virt-manager.enable = true;
  programs.seahorse.enable = true;

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

  nix-mineral = {
    enable = lib.mkDefault false;
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

  virtualisation.docker.enable = true;
  virtualisation.libvirtd = {
    enable = lib.mkDefault false;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    sarasa-gothic
  ];

  services.power-profiles-daemon.enable = true;

  system.stateVersion = "25.11";
}
