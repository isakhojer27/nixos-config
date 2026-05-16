{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ "~/.config/alacritty/themes/noctalia.toml" ];
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
        args = [ "--command" "fastfetch; exec fish" ];
      };
    };
  };

  home.packages = [ pkgs.fastfetch ];
}
