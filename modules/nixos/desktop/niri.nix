# Systemdelen av niri. Användarens niri-config ligger i modules/home/desktop/niri.
{ pkgs, inputs, ... }:
{
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  # Ger pkgs.nirimod (används i HM-modulen)
  nixpkgs.overlays = [
    inputs.nirimod.overlays.default
  ];
}
