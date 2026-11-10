{ lib, pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    # Restoring guests at boot would activate the daemon through its socket.
    onBoot = "ignore";
    qemu.vhostUserPackages = with pkgs; [
      virtiofsd
    ];
  };

  # Keep socket activation and the guests' shutdown/suspend handling.
  systemd.services.libvirtd.wantedBy = lib.mkForce [ ];

  programs.virt-manager.enable = true;

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
