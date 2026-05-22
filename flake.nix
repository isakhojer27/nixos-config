{
  description = "Isak NixOS config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zed-extensions = {
      url = "github:DuskSystems/nix-zed-extensions";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      niri,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/desktop
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              inputs.zed-extensions.overlays.default
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.isakh = import ./home/isakh;
            home-manager.sharedModules = [
              inputs.zed-extensions.homeManagerModules.default
            ];
          }
        ];
      };
    };
}
