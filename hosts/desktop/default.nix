# Stationära datorn. Här väljs vilka roller maskinen har, plus det som
# bara gäller just den här maskinen. modules/nixos/core följer alltid med.
{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/desktop
    ../../modules/nixos/hardware/intel-arc.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/services/mullvad.nix
    ../../modules/nixos/services/printing.nix
  ];

  # TODO fas 2: byt till "desktop" så att det matchar namnet i flake.nix
  networking.hostName = "nixos";

  fileSystems."/media/sekundär" = {
    device = "/dev/disk/by-uuid/63765771-c3d2-47d1-9739-19179886c7c3";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };

  # Användarmiljö på den här maskinen (basen kommer från home/isakh.nix)
  home-manager.users.isakh.imports = [
    ../../modules/home/desktop
    ../../modules/home/apps
    ../../modules/home/gaming.nix
  ];

  system.stateVersion = "26.05";
}
