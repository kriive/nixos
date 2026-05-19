{ pkgs, ... }:

{
  programs.rbw = {
    enable = true; 
    settings = {
      email = "manuel.romei@outlook.it";
      pinentry = pkgs.pinentry-curses;
    };
  };
}
