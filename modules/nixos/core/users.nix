{ pkgs, ... }:
{
  users.users.isakh = {
    isNormalUser = true;
    description = "Isak Höjer";
    shell = pkgs.fish;
    # Fler grupper läggs till av modulerna som behöver dem (t.ex. gaming.nix)
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Krävs för att fish ska kunna vara login-shell (lägger till den i /etc/shells).
  # Själva fish-configen ligger i home-manager: modules/home/core.
  programs.fish.enable = true;
}
