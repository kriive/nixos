{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [
      virtiofsd
    ];
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
  ];

  # libvirt's dnsmasq provides DNS and DHCPv4 to the default NAT network.
  # Keep other host services behind the normal firewall policy.
  networking.firewall.interfaces.virbr0 = {
    # Match the port set documented for NixOS virtual networks/libvirt.
    allowedTCPPorts = [
      53
      67
    ];
    allowedUDPPorts = [
      53 # DNS
      67 # DHCPv4 server
    ];
  };
}
