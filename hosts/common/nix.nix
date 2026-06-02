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
    substituters = [ "https://niri.cachix.org" ];
    trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
