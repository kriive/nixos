{ ... }:

{
  users.users.kriive = {
    isNormalUser = true;
    description = "Manuel Romei";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
}
