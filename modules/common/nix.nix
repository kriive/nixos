{ lib, ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;

      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # The default at 10 is rarely enough.
      log-lines = lib.mkDefault 25;
    };
  };
}
