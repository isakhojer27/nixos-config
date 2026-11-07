{ inputs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };
  home-manager.users.isakh = import ../../../home/isakh.nix;


  home-manager.backupFileExtension = "hm-backup";

  home-manager.sharedModules = [
    inputs.zed-extensions.homeManagerModules.default
  ];
  nixpkgs.overlays = [
    inputs.zed-extensions.overlays.default
  ];
}
