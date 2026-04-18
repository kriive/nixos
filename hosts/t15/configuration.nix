{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../common/base.nix
    ./hardware-configuration.nix
    ./intelme-blacklist.nix
  ];

  boot.initrd.kernelModules = [ "xe" ];
  boot.kernelParams = [
    "xe.force_probe=9a49"
    "module_blacklist=i915"
    "iommu=pt"
    "intel_iommu=on"
  ];
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
  ];

  users.users.kriive = {
    extraGroups = lib.mkAfter [ "libvirtd" ];
  };

  nix-mineral.enable = true;
  virtualisation.libvirtd.enable = true;

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Touchpad Pressure Override]
    MatchUdevType=touchpad
    MatchName=*Synaptics TM3512-010*
    AttrPressureRange=10:8
  '';

  services.throttled.enable = true;
  services.thermald.enable = true;
}
