{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    mangohud
    goverlay
    protonup-qt
    winetricks
    wineWow64Packages.staging
    vulkan-tools
  ];
}
