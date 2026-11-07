{ pkgs, ... }:
{
  users.users.isakh = {
    isNormalUser = true;
    description = "Isak Höjer";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.fish.enable = true;
}
