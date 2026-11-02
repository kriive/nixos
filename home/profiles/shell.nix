{ pkgs, ... }:
{
  imports = [
    ../programs/fish.nix
    ../programs/nix-index.nix
    ../programs/rbw.nix
  ];

  home.packages = with pkgs; [
    eza
    bat
    fastfetch
    htop
    btop
    unzip
    zip
    p7zip
    ethtool
    dig
    mtr
  ];

  home.shellAliases = {
    cat = "bat";
    ls = "eza";
    touchpad-reset = "sudo ${pkgs.kmod}/bin/modprobe -r psmouse && ${pkgs.coreutils}/bin/sleep 5 && sudo ${pkgs.kmod}/bin/modprobe psmouse";
    # Raise the stop threshold first for full charging; lower the start first for 80%.
    charge-100 = "echo 100 | sudo ${pkgs.coreutils}/bin/tee /sys/class/power_supply/BAT0/charge_control_end_threshold && echo 99 | sudo ${pkgs.coreutils}/bin/tee /sys/class/power_supply/BAT0/charge_control_start_threshold";
    charge-80 = "echo 75 | sudo ${pkgs.coreutils}/bin/tee /sys/class/power_supply/BAT0/charge_control_start_threshold && echo 80 | sudo ${pkgs.coreutils}/bin/tee /sys/class/power_supply/BAT0/charge_control_end_threshold";
  };

  programs = {
    ripgrep.enable = true;

    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };

    bash = {
      enable = true;
    };
  };

}
