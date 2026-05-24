{ pkgs, ... }:
{
  home.packages = with pkgs; [
    thunar
    thunar-archive-plugin
    thunar-volman
    tumbler
    xarchiver
  ];
}
