{ inputs, ... }:

{
  imports = [
    inputs.hunk.homeManagerModules.default
  ];

  programs.git.enable = true;

  programs.hunk = {
    enable = true;
    enableGitIntegration = true;
    settings = {
      theme = "graphite";
      mode = "split";
      line_numbers = true;
    };
  };
}
