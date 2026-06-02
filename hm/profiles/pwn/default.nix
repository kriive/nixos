{
  inputs,
  pkgs,
  ...
}:

let
  pwnPython = pkgs.python3.withPackages (
    ps: with ps; [
      pwntools
      ropper
      unicorn
      capstone
      keystone-engine
    ]
  );
  pwnRizin = pkgs.rizin.withPlugins (ps: with ps; [
    jsdec
    rz-ghidra
    sigdb
  ]);
in
{
  imports = [
    ../../modules/shell-core.nix
  ];

  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    inputs.codex.packages.${pkgs.stdenv.hostPlatform.system}.default
    pwnPython
    clang-tools
    gcc
    binutils
    gdb
    gef
    radare2
    rr
    qemu
    one_gadget
    pwninit
    rubyPackages."seccomp-tools"
    strace
    ltrace
    patchelf
    file
    gnumake
    socat
    netcat
    curl
    wget
    git
    tmux
    ripgrep
    jq
    binwalk
    nmap
    tcpdump
    lsof
    pwnRizin
  ];

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.home-manager.enable = true;
}
