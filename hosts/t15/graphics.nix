{ pkgs, ... }:
{
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
}
