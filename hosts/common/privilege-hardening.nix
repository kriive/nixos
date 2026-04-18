{ lib, ... }:

{
  security.doas.enable = lib.mkForce false;
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
    defaultOptions = [ ];
  };
}
