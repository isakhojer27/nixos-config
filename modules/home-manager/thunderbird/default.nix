{ pkgs, config, ... }:
{
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      userChrome = builtins.readFile ./chrome/userChrome.css;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
  home.file.".thunderbird/default/chrome/userContent.css".source = ./chrome/userContent.css;
}
