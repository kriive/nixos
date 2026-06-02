{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    helix
    git
    dnsmasq
  ];
}
