{ pkgs, ... }:

{
imports = [
  ../../modules/home-manager/niri.nix
  ../../modules/home-manager/noctalia.nix
];
  home.username = "isakh";
  home.homeDirectory = "/home/isakh";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  programs.fish.enable = true;

  home.packages = with pkgs; [
    firefox
    libreoffice-fresh
    spotify
    discord

  ];
}
