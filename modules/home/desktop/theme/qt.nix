# Qt-appar (t.ex. PCManFM-Qt, qBittorrent) får färger från Noctalia via qt6ct.
#
# Noctalias inbyggda mall "qt" skriver färgerna till
# ~/.config/qt6ct/colors/noctalia.conf. Den här filen pekar qt6ct dit.
#
# qt6ct.conf hanteras här och är därför skrivskyddad: ändringar i qt6ct:s
# eget fönster sparas inte. Ändra inställningarna nedan istället.
{ config, pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme.name = "qt6ct"; # samma värde sätts på systemnivå
    platformTheme.package = pkgs.qt6Packages.qt6ct;

    qt6ctSettings.Appearance = {
      style = "Fusion"; # följer färgpaletten fullt ut
      custom_palette = true;
      color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
      icon_theme = "Papirus";
    };
  };
}
