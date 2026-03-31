{ lib, pkgs, inputs, ... }:

let
  helper = pkgs.writeShellScriptBin "disabled-by-security-misc" ''
    exit 0
  '';

  helperPath = "${helper}/bin/disabled-by-security-misc";

  intelmeModules = [
    "mei"
    "mei-gsc"
    "mei_gsc_proxy"
    "mei_hdcp"
    "mei-me"
    "mei_phy"
    "mei_pxp"
    "mei-txe"
    "mei-vsc"
    "mei-vsc-hw"
    "mei_wdt"
    "microread_mei"
  ];

  moduleBlacklist = inputs.nix-mineral.lib.fetchGhFile inputs.nix-mineral.lib.sources.module-blacklist;
in
{
  security.doas.enable = lib.mkForce false;
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
    defaultOptions = [ ];
  };

  environment.etc."modprobe.d/nm-disable-intelme-kmodules.conf".text = lib.mkForce (
    lib.concatStringsSep "\n" (map (module: "install ${module} ${helperPath}") intelmeModules) + "\n"
  );

  environment.etc."modprobe.d/nm-module-blacklist.conf".source = lib.mkForce (pkgs.writeText "nm-module-blacklist.conf" (
    lib.replaceStrings [ "/usr/bin/disabled-intelpmt-by-security-misc" ] [ helperPath ] (
      builtins.readFile moduleBlacklist
    )
  ));
}
