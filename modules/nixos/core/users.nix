{ ... }:
{
  users.users.isakh = {
    isNormalUser = true;
    description = "Isak Höjer";
    initialPassword = "test1234";
    # Fler grupper läggs till av modulerna som behöver dem (t.ex. gaming.nix)
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
