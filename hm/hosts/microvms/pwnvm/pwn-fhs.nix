{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  pwnTooling = import ../../../../hosts/microvms/pwnvm/pwn-tooling.nix {
    inherit inputs lib pkgs;
  };
  inherit (pwnTooling) nixLdLibs pwnCliPkgs;

  pwnUbuntu = pkgs.buildFHSEnv {
    pname = "pwn-ubuntu";
    version = "1.0";
    executableName = "pwn-ubuntu";
    runScript = "${pkgs.bashInteractive}/bin/bash";
    multiArch = true;

    targetPkgs = _: pwnCliPkgs;
    multiPkgs = _: nixLdLibs;

    profile = ''
      export PATH="${config.home.profileDirectory}/bin:$PATH"
    '';
  };
in
{
  home.packages = [ pwnUbuntu ];

  home.shellAliases = {
    pwnu = "pwn-ubuntu";
  };
}
