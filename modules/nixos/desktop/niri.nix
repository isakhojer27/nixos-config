{ pkgs, inputs, ... }:
{
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  nixpkgs.overlays = [
    inputs.nirimod.overlays.default
  ];
}
