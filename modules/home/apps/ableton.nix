{ config, pkgs, inputs, ... }:

let
  prefix = "${config.home.homeDirectory}/Musik/ableton";

  ableton = inputs.ableton-linux.packages.${pkgs.stdenv.hostPlatform.system}.default;

  abletonLaunchers = pkgs.runCommand "ableton-launchers" { } ''
    mkdir -p $out/bin $out/share
    for b in ableton-live ableton-wine max9; do
      if [ -e ${ableton}/bin/$b ]; then ln -s ${ableton}/bin/$b $out/bin/$b; fi
    done
    for d in applications icons mime; do
      if [ -e ${ableton}/share/$d ]; then cp -rs ${ableton}/share/$d $out/share/; fi
    done
  '';
in
{
  home.packages = [ abletonLaunchers ];

  home.sessionVariables.ABLETON_WINEPREFIX = prefix;
  systemd.user.sessionVariables.ABLETON_WINEPREFIX = prefix;
}
