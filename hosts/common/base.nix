{ ... }:

{
  imports = [
    ./audio.nix
    ./boot.nix
    ./desktop.nix
    ./dms-greeter.nix
    ./fonts.nix
    ./hardening.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./services.nix
    ./user.nix
    ./virtualization.nix
  ];

  system.stateVersion = "25.11";
}
