{
  inputs,
  lib,
  pkgs,
  ...
}:

let
  pwndbgBase = inputs.pwndbg.packages.${pkgs.stdenv.hostPlatform.system}.default;
  pwndbg = lib.hiPrio (pkgs.symlinkJoin {
    name = "pwndbg-with-gdb";
    paths = [ pwndbgBase ];
    postBuild = ''
      ln -s $out/bin/pwndbg $out/bin/gdb
    '';
  });

  pwnPython = pkgs.python3.withPackages (
    ps: with ps; [
      pwntools
      ropper
      unicorn
      capstone
      keystone-engine
    ]
  );

  pwnCliPkgs = with pkgs; [
    pwnPython
    pwndbg
    gdb
    gef
    radare2
    rizin
    rr
    qemu
    checksec
    one_gadget
    pwninit
    rubyPackages."seccomp-tools"
    strace
    ltrace
    patchelf
    binutils
    file
    gnumake
    gcc
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
  ];

  nixLdLibs = with pkgs; [
    zlib
    openssl
    ncurses5
    readline
    libxcrypt-legacy
    libuuid
    libffi
    libxml2
    glib
  ];
in
{
  inherit
    pwndbg
    pwnPython
    pwnCliPkgs
    nixLdLibs
    ;
}
