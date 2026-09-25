{ inputs, ... }:

{
  nixpkgs = {
    overlays = [ inputs.niri.overlays.niri ];
    config.allowUnfree = true;
    config.chromium.enableWideVine = true;
  };

  documentation.man.enable = true;

  nix.settings = {
    trusted-users = [
      "root"
      "kriive"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
