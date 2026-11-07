{ pkgs, ... }:
{
  imports = [
    ./zen.nix
    ./zed.nix
    ./yazi.nix
    ./ableton.nix
  ];

  home.packages = with pkgs; [
    # media
    spotify
    vlc
    easyeffects
    hypnotix

    # kommunikation
    discord
    mailspring

    # kontor
    obsidian
    euro-office-desktopeditors

    # filer
    localsend
    qbittorrent
    transmission_4-gtk

    # ai
    lmstudio
  ];
}
