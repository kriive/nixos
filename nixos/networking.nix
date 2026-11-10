{
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };
  # Local filesystems do not need connectivity before login.
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.nftables.enable = true;
  networking.firewall.enable = true;
  services.resolved.enable = true;
  services.tailscale = {
    enable = true;
    # Also sets loose reverse path filtering for exit-node traffic.
    useRoutingFeatures = "client";
  };
}
