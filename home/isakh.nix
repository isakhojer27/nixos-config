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
