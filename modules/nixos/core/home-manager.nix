# Kopplar in home-manager. Basen för användaren ligger i home/isakh.nix;
# varje host lägger till sina HM-moduler via home-manager.users.isakh.imports.
{ inputs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };
  home-manager.users.isakh = import ../../../home/isakh.nix;

  # Zed-tillägg: HM-modulen och overlayn som modules/home/apps/zed.nix behöver.
  # Overlays måste sättas på systemnivå eftersom HM kör med useGlobalPkgs.
  home-manager.sharedModules = [
    inputs.zed-extensions.homeManagerModules.default
  ];
  nixpkgs.overlays = [
    inputs.zed-extensions.overlays.default
  ];
}
