{ pkgs, ... }:
{
  boot.loader.limine.enable = true;
  boot.loader.limine.efiSupport = true;
  boot.loader.limine.maxGenerations = 10;
  boot.loader.timeout = 5; # tid att välja en äldre generation om något går sönder

  boot.initrd.systemd.enable = true;

  #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v4;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.enableRedistributableFirmware = true;
}
