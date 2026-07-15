{ pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/niri
    ../../modules/home-manager/noctalia.nix
    ../../modules/home-manager/alacritty.nix
    ../../modules/home-manager/zed.nix
    ../../modules/home-manager/firefox
    ../../modules/home-manager/gtk.nix
    ../../modules/home-manager/thunar.nix
    ../../modules/home-manager/thunderbird
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/yazi.nix
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
    spotify
    discord
    easyeffects
    obsidian
    prismlauncher
    vlc
    ffmpeg
    hypnotix
    localsend
    claude-code
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    onlyoffice-desktopeditors
    lmstudio
    qbittorrent
    nirimod

  ];
}
