{ pkgs, ... }:
{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [
      qtsvg
      qtvirtualkeyboard
      qtmultimedia
    ];
  };

  environment.systemPackages = [
    (pkgs.sddm-astronaut.override {
      embeddedTheme = "japanese_aesthetic";
      themeConfig = {
        Background = "${../../../wallpapers/nix-wallpaper-gear.png}";
        Font = "M+1 Nerd Font";
      };
    })
  ];
}
