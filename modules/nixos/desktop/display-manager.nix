# Inloggningsskärmen: SDDM med temat SilentSDDM.
# https://github.com/uiriansan/SilentSDDM
#
# Temats NixOS-modul sköter SDDM, Qt-beroenden och typsnitt.
# Alla inställningar: https://github.com/uiriansan/SilentSDDM/wiki/Options
{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  # Bakgrundsvideon loopas. Den måste ligga i repot (och vara git add:ad),
  # eftersom SDDM inte kan läsa filer i hemkatalogen.
  video = ../../../assets/login-screen.mp4;

  # Första bildrutan visas medan videon laddar, så att skärmen inte blinkar svart.
  placeholder = pkgs.runCommand "login-screen.png" { nativeBuildInputs = [ pkgs.ffmpeg-headless ]; } ''
    ffmpeg -loglevel error -i ${video} -vframes 1 $out
  '';

  # Typsnitt för all text. Finns via google-fonts i fonts.nix.
  # Alternativ: "JetBrainsMono Nerd Font"
  font = "Press Start 2P";

  # Sektionerna i temat som har ett eget typsnitt
  textSections = [
    "LockScreen.Clock"
    "LockScreen.Date"
    "LockScreen.Message"
    "LoginScreen.LoginArea.Username"
    "LoginScreen.LoginArea.PasswordInput"
    "LoginScreen.LoginArea.LoginButton"
    "LoginScreen.LoginArea.Spinner"
    "LoginScreen.LoginArea.WarningMessage"
    "LoginScreen.MenuArea.Buttons"
    "LoginScreen.MenuArea.Popups"
    "Tooltips"
  ];
in
{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  services.xserver.enable = true;

  programs.silentSDDM = {
    enable = true;

    # Färdiga varianter (förhandsvisningar finns i temats docs/previews):
    # default, default-left, default-right, rei, ken, silvia, nord, gruvbox,
    # everforest, catppuccin-{latte,frappe,macchiato,mocha}, eldritch-{abyss,cthulhu,dusk}
    theme = "default";

    # Filerna kopieras in i temats backgrounds/ och refereras med filnamn nedan
    backgrounds = {
      video = video;
      placeholder = placeholder;
    };

    settings = lib.recursiveUpdate (lib.genAttrs textSections (_: {
      font-family = font;
    })) {
      General.animated-background-placeholder = "login-screen.png";
      LockScreen.background = "login-screen.mp4";
      LoginScreen.background = "login-screen.mp4";
    };
  };
}
