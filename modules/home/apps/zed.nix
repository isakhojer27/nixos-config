{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "kdl"
      "toml"
      "html"
      "git-firefly"
      "jsonnet"
      "jsonl"
    ];
    # Inställningar här vinner över det som ändras inne i Zed vid nästa rebuild.
    # Övriga ändringar i Zed sparas och ligger kvar.
    userSettings = {
      # Gränssnittet
      ui_font_family = "JetBrainsMono Nerd Font";
      ui_font_size = 16;
      ui_font_weight = 200;

      # Editorn
      buffer_font_family = "JetBrains Mono";
      buffer_font_size = 14;
      buffer_font_weight = 400;
      buffer_line_height = "standard";

      lsp = {
        nixd = {
          binary.path_lookup = true;
        };
        nil = {
          binary.path_lookup = true;
        };
      };
    };
  };

  programs.zed-editor-extensions = {
    enable = true;
    packages = with pkgs.zed-extensions; [
      carbonfox
      catppuccin
      catppuccin-blur
      one-dark-pro
      catppuccin-icons
      jetbrains-new-ui-icons
      material-icon-theme
    ];
  };

  home.packages = [
    pkgs.nixd
    pkgs.nil
  ];
}
