{ pkgs, ... }:
{
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    git
    btop
    python3
  ];
}
