{ ... }:

{
  programs.imv = {
    enable = true;
    settings = {
      options = {
        overlay_font = "IoskeleyMonoTerm Nerd Font:10";
        background = "282c34";
      };
      binds = {
        r = "rotate by 90";
      };
    };
  };
}
