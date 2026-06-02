{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl
  ];

  home.shellAliases = {
    k = "kubecolor";
  };

  programs.kubecolor = {
    enable = true;
    enableAlias = true;
  };
}
