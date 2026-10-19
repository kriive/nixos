{
  imports = [
    ../../nixos/base.nix
    ../../nixos/laptop.nix
    ../../nixos/desktop.nix
    ../../nixos/docker.nix
    ../../nixos/hardening.nix
    ../../nixos/virtualization/tools.nix
    ../../nixos/virtualization/libvirt.nix
    ./hardware-configuration.nix
    ./power.nix
    ./touchpad.nix
  ];

  system.stateVersion = "25.11";
  home-manager.users.kriive.imports = [
    ../../home/kriive.nix
    ./home.nix
  ];
  boot.initrd.luks.devices."luks-a36cdc1c-1230-4c91-9ad8-123d54c26969".crypttabExtraOpts = [
    "tpm2-device=auto"
  ];
  nix-mineral.settings.kernel.amd-iommu-force-isolation = false;
  nix-mineral.settings.kernel.intel-iommu = false;
}
