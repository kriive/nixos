{ pkgs, ... }:
{
  home.packages = [ (import ../../pkgs/ghidra.nix { inherit pkgs; }) ];
}
