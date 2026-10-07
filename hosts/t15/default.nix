{
  pkgs,
  ...
}:

{
  imports = [
    ../../nixos/base.nix
    ../../nixos/laptop.nix
    ../../nixos/desktop.nix
    ../../nixos/containers.nix
    ../../nixos/hardening.nix
    ./hardware-configuration.nix
    ./security.nix
  ];

  boot.initrd.kernelModules = [ "xe" ];
  boot.kernelParams = [
    "psmouse.synaptics_intertouch=1"
    "xe.force_probe=9a49"
    "module_blacklist=i915"
    "iommu=pt"
    "intel_iommu=on"
    "btusb.enable_autosuspend=0"
  ];
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
  ];

  system.stateVersion = "25.11";
  home-manager.users.kriive = import ../../home/kriive.nix;

  # Retain the address previously used by this host's Ghidra proxy.
  local.containers.ipv4Address = "10.53.43.1/24";

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Touchpad Pressure Override]
    MatchUdevType=touchpad
    MatchName=*Synaptics TM3512-010*
    AttrPressureRange=10:8
  '';

  services.throttled.enable = true;
  services.thermald.enable = true;
}
