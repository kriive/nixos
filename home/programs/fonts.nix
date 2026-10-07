{ pkgs, ... }:
{
  home.packages = [ (pkgs.callPackage ../../pkgs/tx02-fonts.nix { }) ];
}
