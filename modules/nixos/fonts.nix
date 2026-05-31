{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts._3270
    gohufont
    hack-font
    nerd-fonts.jetbrains-mono
    google-fonts
    scientifica
    texlivePackages.jetbrainsmono-otf
    nerd-fonts.meslo-lg
  ];
}
