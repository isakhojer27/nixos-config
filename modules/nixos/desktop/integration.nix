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

  xdg.mime.defaultApplications."inode/directory" = "pcmanfm-qt.desktop";

  systemd.user.services.dbus-broker = {
    restartIfChanged = false;
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    papirus-icon-theme
  ];
}
