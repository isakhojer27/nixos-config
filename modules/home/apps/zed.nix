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
    userSettings = {
      ui_font_size = 16;
      buffer_font_size = 14;
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
