# Tema: färgpaletter och mallar för Noctalia, plus GTK, Qt och ikoner.
#
# Noctalia äger färgerna och skriver dem till varje programs temafil när
# paletten byts. Här ligger det Noctalia läser (paletter, mallar) och
# det som får programmen att använda Noctalias färger.
{ lib, ... }:
let
  # Alla .json i ./palettes länkas var för sig till ~/.config/noctalia/palettes/,
  # så att egna paletter som redan ligger där får vara kvar.
  palettes = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".json" name) (
    builtins.readDir ./palettes
  );
in
{
  imports = [
    ./gtk.nix
    ./qt.nix
    ./icons.nix
  ];

  xdg.configFile = {
    "noctalia/templates.toml".source = ./templates.toml;
  }
  // lib.mapAttrs' (
    name: _: lib.nameValuePair "noctalia/palettes/${name}" { source = "${./palettes}/${name}"; }
  ) palettes;
}
