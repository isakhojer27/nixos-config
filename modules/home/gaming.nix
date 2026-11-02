{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    lutris
    mangohud
    goverlay
    protonup-qt
    winetricks
    wineWow64Packages.staging
    vulkan-tools
    prismlauncher

    inputs.bedrock-on-linux.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
