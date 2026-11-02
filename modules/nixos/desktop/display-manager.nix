# Inloggningsskärmen: SDDM med temat LentenRose (packages/sddm-lentenrose.nix).
{ pkgs, ... }:
let
  lentenrose = pkgs.callPackage ../../../packages/sddm-lentenrose.nix {
    # Värden här skriver över temats theme.conf. Typsnittet Manrope kommer
    # från google-fonts i fonts.nix.
    themeConfig = {
      Font = "Manrope";
    };
  };
in
{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "LentenRose";
    extraPackages = with pkgs.kdePackages; [
      qt5compat # skuggeffekterna i temat
      qtsvg # användarikonen
      qtvirtualkeyboard # skärmtangentbordet
    ];
  };

  environment.systemPackages = [ lentenrose ];
}
