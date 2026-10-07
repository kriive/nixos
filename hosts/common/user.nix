{ ... }:

{
  users.users.kriive = {
    isNormalUser = true;
    description = "Manuel Romei";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "incus-admin"
    ];
  };

  services.accounts-daemon.enable = true;
  systemd.services.accounts-daemon.serviceConfig = {
    PrivateTmp = false;
  };
}
