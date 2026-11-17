{ config, pkgs, ... }:
{
  imports = [
    ./locale.nix
    ./networking.nix
    ./users.nix
  ];

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
  nix.package = pkgs.nixVersions.latest.overrideScope (
    _final: prev: {
      nix-cli = prev.nix-cli.override {
        withMimalloc = false;
      };
    }
  );
  # Comma embeds Nix paths at build time, so use the same allocator-compatible package.
  nixpkgs.overlays = [
    (_final: prev: {
      comma = prev.comma.override { nix = config.nix.package; };
    })
  ];
  documentation.man.enable = true;
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    helix
    git
    bubblewrap
  ];
}
