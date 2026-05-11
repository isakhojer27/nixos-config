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
  };

  outputs = inputs@{ self, nixpkgs, home-manager, niri, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;

      # Gör inputs tillgängliga i NixOS-moduler
      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./hosts/desktop

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # VIKTIGT: skickar inputs även till Home Manager
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.users.isakh = import ./home/isakh;
        }
      ];
    };
  };
}
