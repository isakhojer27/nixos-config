# Det som ALLA maskiner har. Importeras automatiskt via mkHost i flake.nix.
{
  imports = [
    ./boot.nix
    ./nix.nix
    ./locale.nix
    ./networking.nix
    ./users.nix
    ./home-manager.nix
    ./packages.nix
  ];
}
