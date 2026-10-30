{
  description = "Isak NixOS config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nirimod = {
      url = "github:srinivasr/nirimod";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bedrock-on-linux = {
      url = "github:Wyze3306/BedrockOnLinux";
    };
    zed-extensions = {
      url = "github:DuskSystems/nix-zed-extensions";
    };
    ableton-linux = {
      url = "github:shibco/ableton-linux/aceb236a81656c609274afbf27fd54eb5017e5e2";
    };
  };
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    let
      # Bygger en maskin från hosts/<name>. Allt i modules/nixos/core
      # följer alltid med; resten väljer varje host själv.
      mkHost =
        name:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/${name}
            ./modules/nixos/core
            home-manager.nixosModules.home-manager
          ];
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost "desktop";
        # laptop = mkHost "laptop";
        # server = mkHost "server";
      };
    };
}
