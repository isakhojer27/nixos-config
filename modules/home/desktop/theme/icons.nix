# Ikontema: Papirus, med mappikonerna omfärgade efter Noctalias palett.
#
# Så fungerar det:
#  1. Nix bygger "original": bara mappikonerna (places) ur Papirus, som ett
#     eget litet ikontema "Noctalia-Papirus" som ärver resten från Papirus.
#  2. Noctalia kör mallen templates/Noctalia-Papirus.sh varje gång paletten
#     byts. Den kopierar originalet till ~/.local/share/icons/Noctalia-Papirus
#     och byter färgerna där.
#  3. Första gången, innan Noctalia hunnit köra mallen, lägger home-manager
#     dit en ofärgad kopia så att ikonerna aldrig saknas.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Ikontemat som Noctalia-Papirus bygger på. Byt till "Papirus-Dark" om du
  # vill ha de mörka varianterna av de minsta ikonerna.
  base = "Papirus";
  themeName = "Noctalia-Papirus";
  themeDir = "${config.xdg.dataHome}/icons/${themeName}";

  original = pkgs.runCommandLocal "noctalia-papirus-original" { } ''
    src=${pkgs.papirus-icon-theme}/share/icons/${base}
    mkdir -p $out

    # Kopiera alla places-mappar (inte @2x, de länkas nedan)
    for dir in $(grep -E '^Directories=' $src/index.theme | cut -d= -f2 | tr ',' '\n' | grep '/places$'); do
      if [ -d "$src/$dir" ]; then
        mkdir -p "$out/$(dirname "$dir")"
        cp -rL "$src/$dir" "$out/$dir"
      fi
    done

    # @2x-varianterna är samma filer
    for size in $out/*x*; do
      size=$(basename "$size")
      ln -s "$size" "$out/$size@2x"
    done

    # index.theme: nytt namn, ärver från ${base}, och listar bara mappar som finns
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
      pkgs.gtk3 # gtk-update-icon-cache
      pkgs.glib # gsettings
    ];
  };
in
{
  gtk.iconTheme = {
    name = themeName;
    package = pkgs.papirus-icon-theme; # ger ${base}, som Noctalia-Papirus ärver från
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
