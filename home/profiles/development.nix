{ pkgs, ... }:
{
  imports = [
    ../programs/helix.nix
    ../programs/kubernetes.nix
    ../programs/opencode.nix
    ../programs/tmux.nix
    ../programs/zellij.nix
  ];

  programs.git.enable = true;
  home.packages = with pkgs; [
    clang-tools
    ruff
    nixfmt
    codex
    jujutsu
  ];
}
