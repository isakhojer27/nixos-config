# Basen för användaren isakh, på alla maskiner.
# Det som bara hör till vissa maskiner läggs till i host-filen
# via home-manager.users.isakh.imports.
{ ... }:
{
  imports = [
    ../modules/home/core
  ];

  home.username = "isakh";
  home.homeDirectory = "/home/isakh";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
