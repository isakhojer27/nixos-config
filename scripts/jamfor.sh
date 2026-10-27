#!/usr/bin/env bash
# Jämför det den här checkouten bygger med snapshots tagna tidigare.
#
# Användning (från repots rot):
#   scripts/jamfor.sh ../snap-system ../snap-hm
#
# Byt host med HOST=laptop scripts/jamfor.sh …
#
# Visar tre saker:
#   1. Paket som lagts till, tagits bort eller bytt version (nvd)
#   2. Filer i /etc som ändrats
#   3. Filer som home-manager lägger i ~ som ändrats
# Hashar i /nix/store-sökvägar ignoreras, eftersom de ändras av rent
# tekniska skäl (t.ex. att en paketlista byggs i annan ordning).

set -euo pipefail

host="${HOST:-desktop}"
old_sys="${1:?ange snapshot av systemet, t.ex. ../snap-system}"
old_hm="${2:?ange snapshot av home-manager-filerna, t.ex. ../snap-hm}"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "Bygger $host …"
nix build ".#nixosConfigurations.$host.config.system.build.toplevel" -o "$tmp/system"
nix build ".#nixosConfigurations.$host.config.home-manager.users.isakh.home-files" -o "$tmp/hm"

# Ett fingeravtryck per fil: sökväg + kontrollsumma av innehållet
# där /nix/store-hashar har ersatts med ett fast värde.
# Länkar som pekar ut ur /nix/store (t.ex. till /var/lib) läses inte;
# där jämförs bara vart länken pekar.
fingerprint() {
  (
    cd "$1"
    find -L . -type f 2>/dev/null | LC_ALL=C sort | while IFS= read -r f; do
      real="$(readlink -f "$f")"
      case "$real" in
        /nix/store/*)
          sum="$(sed -E 's#/nix/store/[a-z0-9]{32}-#/nix/store/-#g' "$f" | md5sum | cut -c1-12)"
          printf '%s %s\n' "$f" "$sum"
          ;;
        *)
          printf '%s -> %s\n' "$f" "$real"
          ;;
      esac
    done
  )
}

compare() {
  if diff <(fingerprint "$1") <(fingerprint "$2"); then
    echo "Inga skillnader."
  fi
}

echo
echo "=== Paket ==="
nix run nixpkgs#nvd -- diff "$old_sys" "$tmp/system"

echo
echo "=== Filer i /etc ==="
compare "$old_sys/etc" "$tmp/system/etc"

echo
echo "=== Filer från home-manager ==="
compare "$old_hm" "$tmp/hm"
