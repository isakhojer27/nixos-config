# Grundverktyg som ska finnas på alla maskiner, även för root.
# Paket som hör till ett visst ämne ligger i den modulen istället.
{ pkgs, ... }:
{
  # Kör binärer som inte är byggda för NixOS
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    git
    btop
    python3
  ];
}
