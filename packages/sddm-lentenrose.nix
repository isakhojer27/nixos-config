# SDDM-temat LentenRose: https://github.com/theophinetheodore/LentenRose
#
# Temat är skrivet för Qt5, men NixOS kör SDDM med Qt6. Den enda skillnaden
# som påverkar temat är att skuggeffekterna (DropShadow) flyttat till modulen
# Qt5Compat.GraphicalEffects i Qt6, så importen byts ut nedan.
#
# themeConfig skriver över värden i temats theme.conf, t.ex.
#   { Background = "${./bild.png}"; Font = "Manrope"; }
{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  formats,
  themeConfig ? { },
}:
stdenvNoCC.mkDerivation {
  pname = "sddm-lentenrose";
  version = "0-unstable-2023-10-30";

  src = fetchFromGitHub {
    owner = "theophinetheodore";
    repo = "LentenRose";
    rev = "849a5f4d8386611551a51f4ba16566ae9ef4dee9";
    hash = "sha256-acanCj9LMS6xYjw+ZUKVW3RLvN1PJC4Dyjnv1Ri+R98=";
  };

  dontWrapQtApps = true;

  installPhase =
    let
      dir = "$out/share/sddm/themes/LentenRose";
      userConfig = (formats.ini { }).generate "theme.conf.user" { General = themeConfig; };
    in
    ''
      runHook preInstall

      mkdir -p ${dir}
      cp -r . ${dir}
      rm -rf ${dir}/Previews ${dir}/README.md

      # Qt5 -> Qt6
      grep -rl 'import QtGraphicalEffects' ${dir} | xargs sed -i \
        's/import QtGraphicalEffects 1.0/import Qt5Compat.GraphicalEffects/'
      # Qt6 vägrar lägga sessionsväljaren (ComboBox) i en property av typen
      # Control, vilket bryter tangentbordsnavigeringen dit. Item fungerar.
      sed -i 's/property Control exposeSession/property Item exposeSession/' \
        ${dir}/Components/Input.qml ${dir}/Components/SessionButton.qml
      # Klockan visar tim/min/sek på varsin rad. Temat läser formatet från
      # språkinställningen, som i Qt6 saknar sekunder (och i en_US har AM/PM).
      # Fast 24-timmarsformat ger samma klocka som på temats skärmdump.
      substituteInPlace ${dir}/Components/Clock.qml \
        --replace-fail 'Locale.ShortFormat' '"HH:mm:ss"'

      ${lib.optionalString (themeConfig != { }) "ln -s ${userConfig} ${dir}/theme.conf.user"}

      runHook postInstall
    '';

  meta = {
    description = "Elegant SDDM theme, forked from Sugar Candy";
    homepage = "https://github.com/theophinetheodore/LentenRose";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
