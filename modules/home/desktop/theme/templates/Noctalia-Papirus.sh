#!/usr/bin/env bash
# Noctalia-mall: färgar om Papirus mappikoner efter aktiv palett.
# Bygger på bwoah-md:s Noctalia-Papirus.sh, men utgår från en orörd
# kopia i /nix/store varje gång istället för en git-repo med en gren per färg.
#
# Noctalia fyller i färgfälten nedan och kör resultatet (se templates.toml).
# Sökvägarna till originalikonerna och verktygen fylls i av Nix (icons.nix).
set -euo pipefail
export PATH="@path@:$PATH"

PRIMARY="{{colors.primary.default.hex}}"
SECONDARY="{{colors.secondary.default.hex}}"
CONTAINER="{{colors.primary_container.default.hex}}"
COLOR="${PRIMARY:1}"
COLOR2="${SECONDARY:1}"
COLOR_DARK="${CONTAINER:1}"

ORIGINAL="@original@"
THEME_NAME="Noctalia-Papirus"
THEME_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/icons/$THEME_NAME"

# Bygg den nya versionen bredvid den gamla och byt sedan, så att
# programmen aldrig ser en halvfärdig ikonmapp.
mkdir -p "$(dirname "$THEME_DIR")"
tmp="$(mktemp -d "$THEME_DIR.XXXXXX")"
trap 'rm -rf "$tmp"' EXIT

cp -r "$ORIGINAL"/. "$tmp"/
chmod -R u+w "$tmp"

# Samma färgbyten som originalmallen: Papirus blå/gula mappfärger
# byts mot palettens primär-, sekundär- och containerfärg.
find "$tmp" -name "*.svg" -path "*/places/*" -type f -print0 |
    xargs -0 -r -P "$(nproc)" sed -i \
        -e "s/fill:#5294e2/fill:#${COLOR}/gI" \
        -e "s/fill:#4877b1/fill:#${COLOR_DARK}/gI" \
        -e "s/fill:#1d344f/fill:#${COLOR_DARK}/gI" \
        -e "s/fill:#c9a554/fill:#${COLOR2}/gI" \
        -e "s/fill:#e4e4e4/fill:#${COLOR2}/gI" \
        -e "s/fill:#ffffff/fill:#${COLOR2}/gI"

gtk-update-icon-cache -f -t "$tmp" 2>/dev/null || true

rm -rf "$THEME_DIR.old"
if [ -e "$THEME_DIR" ]; then
    mv "$THEME_DIR" "$THEME_DIR.old"
fi
mv "$tmp" "$THEME_DIR"
rm -rf "$THEME_DIR.old"
trap - EXIT

# Få öppna GTK-appar att läsa in ikonerna på nytt (byt tema fram och tillbaka).
if command -v gsettings >/dev/null 2>&1 &&
   gsettings list-schemas 2>/dev/null | grep -qx 'org.gnome.desktop.interface'; then
    CURRENT=$(gsettings get org.gnome.desktop.interface icon-theme 2>/dev/null | tr -d "'")
    if [[ "$CURRENT" == "$THEME_NAME" ]]; then
        gsettings set org.gnome.desktop.interface icon-theme "hicolor" 2>/dev/null || true
        sleep 0.2
        gsettings set org.gnome.desktop.interface icon-theme "$THEME_NAME" 2>/dev/null || true
    fi
fi
