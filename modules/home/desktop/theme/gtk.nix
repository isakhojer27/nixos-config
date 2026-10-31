# GTK-appar får färger från Noctalias mallar "gtk3"/"gtk4" (noctalia.css).
{ pkgs, ... }:
{
  xdg.configFile."gtk-4.0/gtk.css".force = true;
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    # iconTheme sätts i icons.nix
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
