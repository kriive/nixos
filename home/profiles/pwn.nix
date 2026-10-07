{ pkgs, ... }:
{
  home.packages = import ../../pkgs/pwn-tools.nix { inherit pkgs; };
}
