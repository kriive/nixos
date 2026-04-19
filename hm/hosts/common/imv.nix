{ ... }:

{
  programs.imv = {
    enable = true;
    settings = {
      options = {
        overlay_font = "JetBrainsMono Nerd Font:10";
        background = "282c34";
      };
      binds = {
        r = "rotate by 90";
      };
    };
  };
}
