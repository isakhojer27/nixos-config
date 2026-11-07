{ config, pkgs, ... }:
let
  font = ''"MesloLGL Nerd Font,10"'';
in
{
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    platformTheme.package = pkgs.qt6Packages.qt6ct;

    style.package = pkgs.klassy;

    qt6ctSettings = {
      Appearance = {
        style = "Klassy";
        custom_palette = true;
        color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
        # icon_theme sätts i icons.nix
      };
      Fonts = {
        general = font;
        fixed = font;
      };
    };
  };
}
