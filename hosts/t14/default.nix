{ lib, ... } :
{
  imports = [
    ../../nixos/base.nix
    ../../nixos/laptop.nix
    ../../nixos/desktop.nix
    ../../nixos/containers.nix
    ../../nixos/hardening.nix
    ./hardware-configuration.nix
    ./power.nix
    ./touchpad.nix
  ];

  system.stateVersion = "25.11";
  home-manager.users.kriive.imports = [
    ../../home/kriive.nix
    ./home.nix
  ];
  # Preserve the existing bridge subnet on this machine.
  local.containers.ipv4Address = "10.46.142.1/24";
  boot.tmp.useTmpfs = true;
  boot.initrd.luks.devices."luks-a36cdc1c-1230-4c91-9ad8-123d54c26969".crypttabExtraOpts = [
    "tpm2-device=auto"
  ];
  nix-mineral.settings.kernel.amd-iommu-force-isolation = false;
  nix-mineral.settings.kernel.intel-iommu = false;
}
