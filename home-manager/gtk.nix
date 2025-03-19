{ pkgs, ... }:

{
  gtk = {
    enable = true;
	 	font.name = "DejaVu";
    font.size = 11;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
