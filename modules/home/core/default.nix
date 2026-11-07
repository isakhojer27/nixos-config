{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = "set -g fish_greeting";
  };

  home.packages = with pkgs; [
    claude-code
    ffmpeg
    unzip
    p7zip
  ];
}
