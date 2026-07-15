{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ "~/.config/alacritty/themes/noctalia.toml" ];
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Italic";
        };
        size = 10.0;
      };
      window = {
        opacity = 0.5;
        blur = true;
        padding = {
          x = 12;
          y = 12;
        };
      };
      terminal.shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [
          "--command"
          "fastfetch; exec fish"
        ];
      };
    };
  };
  home.packages = [ pkgs.fastfetch ];
}
