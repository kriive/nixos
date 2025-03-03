{ inputs, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    mouse = true;
    keyMode = "vi";
    prefix = "C-a";
    extraConfig = ''
    bind | split-window -h
    bind - split-window -v
    unbind '"'
    unbind %
    unbind C-Left
    unbind C-Right

    bind -n M-h select-pane -L
    bind -n M-l select-pane -R
    bind -n M-k select-pane -U
    bind -n M-j select-pane -D
    '';
    shell = "${inputs.fish-nixpkgs.legacyPackages."${pkgs.system}".fish}/bin/fish";
  };
}
