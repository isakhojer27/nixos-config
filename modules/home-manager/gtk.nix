{ pkgs, ... }:
{
  xdg.configFile."gtk-4.0/gtk.css".force = true;
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 12;
    };
    gtk4.extraCss = ''
      @import url("noctalia.css");
    '';
    gtk4.theme = null;
  };
}
