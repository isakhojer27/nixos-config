{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.file.".config/niri/config.kdl".source = ./config.kdl;
  home.file.".config/niri/animation.kdl".source = ./animation.kdl;
  home.file.".config/niri/autostart.kdl".source = ./autostart.kdl;
  home.file.".config/niri/keybinds.kdl".source = ./keybinds.kdl;
  home.file.".config/niri/input.kdl".source = ./input.kdl;
  home.file.".config/niri/display.kdl".source = ./display.kdl;
  home.file.".config/niri/layout.kdl".source = ./layout.kdl;
  home.file.".config/niri/rules.kdl".source = ./rules.kdl;
  home.file.".config/niri/misc.kdl".source = ./misc.kdl;
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
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
