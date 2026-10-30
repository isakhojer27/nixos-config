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
# (Python istället för en skal-loop: /etc har tiotusentals filer, t.ex.
# fish-completions, och att starta flera processer per fil tar för lång tid.)
fingerprint() {
  python3 - "$1" <<'PY'
import hashlib, os, re, sys

root = sys.argv[1]
store_hash = re.compile(rb"/nix/store/[a-z0-9]{32}-")
seen_dirs = set()
lines = []

for dirpath, dirnames, filenames in os.walk(root, followlinks=True):
    real_dir = os.path.realpath(dirpath)
    if not real_dir.startswith("/nix/store/") or real_dir in seen_dirs:
        dirnames[:] = []  # gå inte in i mappar utanför storen, eller i loopar
        if not real_dir.startswith("/nix/store/"):
            lines.append(f"./{os.path.relpath(dirpath, root)} -> {real_dir}")
        continue
    seen_dirs.add(real_dir)
    for name in filenames:
        path = os.path.join(dirpath, name)
        rel = "./" + os.path.relpath(path, root)
        real = os.path.realpath(path)
        if not real.startswith("/nix/store/"):
            lines.append(f"{rel} -> {real}")
            continue
        try:
            with open(path, "rb") as f:
                data = store_hash.sub(b"/nix/store/-", f.read())
            lines.append(f"{rel} {hashlib.md5(data).hexdigest()[:12]}")
        except OSError:
            lines.append(f"{rel} (kunde inte läsas)")

for line in sorted(lines):
    print(line)
PY
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
