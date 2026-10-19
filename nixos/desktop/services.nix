{
  programs.seahorse.enable = true;
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.accounts-daemon.enable = true;
  # Preserve until greeter/account integration is verified with the default sandbox.
  # See docs/workarounds.md.
  systemd.services.accounts-daemon.serviceConfig.PrivateTmp = false;
}
