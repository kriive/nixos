{ ... }:

{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        shell = "fish";
        font = "JetBrainsMono Nerd Font:size=12";
        dpi-aware = "no";
      };
      colors = {
        foreground = "eeeeec";
        background = "111416";
        regular0 = "000000";
        regular1 = "cd0000";
        regular2 = "00cd00";
        regular3 = "cdcd00";
        regular4 = "1093f5";
        regular5 = "cd00cd";
        regular6 = "00cdcd";
        regular7 = "faebd7";
        bright0 = "404040";
        bright1 = "ff0000";
        bright2 = "00ff00";
        bright3 = "ffff00";
        bright4 = "11b5f6";
        bright5 = "ff00ff";
        bright6 = "00ffff";
        bright7 = "ffffff";
      };
    };
  };
}
