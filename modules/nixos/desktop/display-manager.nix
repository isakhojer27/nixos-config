# Inloggningsskärmen: SDDM med temat SilentSDDM.
# https://github.com/uiriansan/SilentSDDM
#
# Temats NixOS-modul sköter SDDM, Qt-beroenden och typsnitt.
# Alla inställningar: https://github.com/uiriansan/SilentSDDM/wiki/Options
{ inputs, ... }:
{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  services.xserver.enable = true;

  programs.silentSDDM = {
    enable = true;

    # Färdiga varianter (förhandsvisningar finns i temats docs/previews):
    # default, default-left, default-right, rei, ken, silvia, nord, gruvbox,
    # everforest, catppuccin-{latte,frappe,macchiato,mocha}, eldritch-{abyss,cthulhu,dusk}
    theme = "default";

    # Egna bakgrunder och inställningar läggs till här senare, t.ex.:
    # backgrounds.mountains = ../../../wallpapers/mountains.jpg;
    # settings."LoginScreen".background = "mountains.jpg";
    # settings."LockScreen".background = "mountains.jpg";
  };
}
