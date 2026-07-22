{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dank-greeter.nixosModules.default
  ];

  programs.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/kriive";
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };
}
