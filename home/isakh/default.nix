{ pkgs, ... }:

{
imports = [
  ../../modules/home-manager/niri.nix
  ../../modules/home-manager/noctalia.nix
  ../../modules/home-manager/alacritty.nix
];
  home.username = "isakh";
  home.homeDirectory = "/home/isakh";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  programs.fish = {
  enable = true;
  interactiveShellInit = "set -g fish_greeting";
};

  home.packages = with pkgs; [
    firefox
    libreoffice-fresh
    spotify
    discord

  ];
}
