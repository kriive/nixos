{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dnsmasq
    quickemu
    virt-viewer
  ];
}
