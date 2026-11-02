# Grafiska program. Program med egen konfiguration har en egen fil;
# program som bara installeras ligger i listan nedan.
{ pkgs, ... }:
{
  imports = [
    ./zen.nix
    ./zed.nix
    ./yazi.nix
    ./ableton.nix
  ];

  home.packages = with pkgs; [
    # Media
    spotify
    vlc
    easyeffects
    hypnotix

    # Kommunikation
    discord
    mailspring

    # Kontor och anteckningar
    obsidian
    euro-office-desktopeditors

    # Filöverföring
    localsend
    qbittorrent
    transmission_4-gtk

    # AI
    lmstudio
  ];
}
