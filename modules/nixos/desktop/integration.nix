# Det som får appar att fungera ihop med skrivbordet:
# portals (filväljare, skärmdelning), dconf, gvfs och tema-variabler.
{ pkgs, ... }:
{
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common = {
      default = "gtk";
      "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      "org.freedesktop.impl.portal.Screenshot" = "gnome";
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "adw-gtk3";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  # Standardprogram för mappar (filhanteraren installeras i
  # modules/home/desktop/file-manager.nix). Sätts här i /etc/xdg istället för
  # i home-manager, så att en befintlig ~/.config/mimeapps.list inte krockar.
  xdg.mime.defaultApplications."inode/directory" = "pcmanfm-qt.desktop";

  # Starta inte om dbus vid rebuild (kan döda den grafiska sessionen)
  systemd.user.services.dbus-broker = {
    restartIfChanged = false;
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    papirus-icon-theme
  ];
}
