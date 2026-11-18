{ config, pkgs, ... }:
{
  programs.go.enable = true;
  home.sessionPath = [ "${config.home.homeDirectory}/go/bin" ];
  home.packages = with pkgs; [
    gopls
    delve
    gotools # goimports, stringer, and other upstream tools
    go-tools # staticcheck
    gofumpt
    golangci-lint
    govulncheck
    gotestsum
    gotests
    gomodifytags
    impl
    gcc # CGO and the race detector
    pkg-config
    gnumake
  ];
}
