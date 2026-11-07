{
  config,
  lib,
  pkgs,
  ...
}:
let
  base = "Papirus";
  themeName = "Noctalia-Papirus";
  themeDir = "${config.xdg.dataHome}/icons/${themeName}";

  original = pkgs.runCommandLocal "noctalia-papirus-original" { } ''
    src=${pkgs.papirus-icon-theme}/share/icons/${base}
    mkdir -p $out

    for dir in $(grep -E '^Directories=' $src/index.theme | cut -d= -f2 | tr ',' '\n' | grep '/places$'); do
      if [ -d "$src/$dir" ]; then
        mkdir -p "$out/$(dirname "$dir")"
        cp -rL "$src/$dir" "$out/$dir"
      fi
    done

    for size in $out/*x*; do
      size=$(basename "$size")
      ln -s "$size" "$out/$size@2x"
    done

    awk -F= -v out="$out" '
      /^Name=/     { print "Name=${themeName}"; next }
      /^Inherits=/ { print "Inherits=${base},breeze,hicolor"; next }
      /^(Scaled)?Directories=/ {
        n = split($2, dirs, ","); kept = ""
        for (i = 1; i <= n; i++) {
          if (system("test -d \"" out "/" dirs[i] "\"") == 0)
            kept = kept (kept == "" ? "" : ",") dirs[i]
        }
        print $1 "=" kept; next
      }
      { print }
    ' $src/index.theme > $out/index.theme
  '';

  template = pkgs.replaceVars ./templates/Noctalia-Papirus.sh {
    inherit original;
    path = lib.makeBinPath [
      pkgs.coreutils
      pkgs.findutils
      pkgs.gnused
      pkgs.gtk3
      pkgs.glib
    ];
  };
in
{
  gtk.iconTheme = {
    name = themeName;
    package = pkgs.papirus-icon-theme;
  };
  qt.qt6ctSettings.Appearance.icon_theme = themeName;

  xdg.configFile."noctalia/templates/Noctalia-Papirus.sh".source = template;

  home.activation.noctaliaPapirus = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e "${themeDir}" ]; then
      run mkdir -p "$(dirname "${themeDir}")"
      run cp -r "${original}" "${themeDir}"
      run chmod -R u+w "${themeDir}"
    fi
  '';
}
