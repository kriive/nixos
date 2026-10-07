{ pkgs, ... }:
{
  imports = [ ./locale.nix ];

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "kriive"
    ];
  };
  documentation.man.enable = true;
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    helix
    git
  ];

  users.users.kriive = {
    isNormalUser = true;
    description = "Manuel Romei";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
  };
  services.resolved.enable = true;
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}
