{ config, pkgs, inputs, ... }:
{
  home.file.".config/niri/config.kdl".source = ../../modules/features/niri/config.kdl;
  home.file.".config/niri/animation.kdl".source = ../../modules/features/niri/animation.kdl;
  home.file.".config/niri/autostart.kdl".source = ../../modules/features/niri/autostart.kdl;
  home.file.".config/niri/keybinds.kdl".source = ../../modules/features/niri/keybinds.kdl;
  home.file.".config/niri/input.kdl".source = ../../modules/features/niri/input.kdl;
  home.file.".config/niri/display.kdl".source = ../../modules/features/niri/display.kdl;
  home.file.".config/niri/layout.kdl".source = ../../modules/features/niri/layout.kdl;
  home.file.".config/niri/rules.kdl".source = ../../modules/features/niri/rules.kdl;
  home.file.".config/niri/misc.kdl".source = ../../modules/features/niri/misc.kdl;

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  gtk = {
  enable = true;
  iconTheme = {
    name = "Papirus";
    package = pkgs.papirus-icon-theme;
  };
  cursorTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 12;
  };
};

  home.packages = with pkgs; [
    xwayland-satellite
    fuzzel
    waybar
    swaylock
    playerctl
    brightnessctl
    xdg-desktop-portal-gtk
  ];
}
