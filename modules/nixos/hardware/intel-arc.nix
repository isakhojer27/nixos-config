# Intel Arc-grafikkort
{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
      vulkan-validation-layers
    ];
    extraPackages32 = with pkgs; [
      pkgs.driversi686Linux.intel-media-driver
    ];
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  environment.systemPackages = with pkgs; [
    mesa
    vulkan-loader
  ];
}
