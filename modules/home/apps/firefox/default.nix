{ pkgs, config, ... }:
{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    nativeMessagingHosts = [ pkgs.pywalfox-native ];
    profiles.default = {
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = builtins.readFile ./chrome/userChrome.css;
      userContent = builtins.readFile ./chrome/userContent.css;
    };
  };

  home.file.".mozilla/firefox/default/user.js".source = ./chrome/user.js;
  home.file.".mozilla/firefox/default/chrome/theme".source = ./chrome/theme;

}
