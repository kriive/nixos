{ pkgs }:

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
  pwnRizin = pkgs.rizin.withPlugins (
    ps: with ps; [
      jsdec
      rz-ghidra
      sigdb
    ]
  );
in
with pkgs;
[
  codex
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
]
