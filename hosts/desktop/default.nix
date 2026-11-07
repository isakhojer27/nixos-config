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

  networking.hostName = "desktop";

  fileSystems."/media/sekundär" = {
    device = "/dev/disk/by-uuid/63765771-c3d2-47d1-9739-19179886c7c3";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };

  home-manager.users.isakh.imports = [
    ../../modules/home/desktop
    ../../modules/home/apps
    ../../modules/home/gaming.nix
  ];

  system.stateVersion = "26.05";
}
