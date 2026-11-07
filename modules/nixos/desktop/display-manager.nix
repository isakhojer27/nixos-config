{
  inputs,
  lib,
  pkgs,
  ...
}:
let

  video = ../../../assets/login-screen.mp4;

  placeholder = pkgs.runCommand "login-screen.png" { nativeBuildInputs = [ pkgs.ffmpeg-headless ]; } ''
    ffmpeg -loglevel error -i ${video} -vframes 1 $out
  '';

  font = "Press Start 2P";

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

    # default, default-left, default-right, rei, ken, silvia, nord, gruvbox,
    # everforest, catppuccin-{latte,frappe,macchiato,mocha}, eldritch-{abyss,cthulhu,dusk}
    theme = "default";

    backgrounds = {
      video = video;
      placeholder = placeholder;
    };

    settings = lib.recursiveUpdate (lib.genAttrs textSections (_: {
      font-family = font;
    })) {
      General.animated-background-placeholder = "login-screen.png";
      "LockScreen.Date".margin-top = 20;
      LockScreen.background = "login-screen.mp4";
      LoginScreen.background = "login-screen.mp4";
    };
  };
}
