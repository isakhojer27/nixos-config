# Zen-webbläsaren, med ffmpeg tillgängligt så att video fungerar.
{ pkgs, inputs, ... }:
let
  zenBase = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;

  zen = pkgs.symlinkJoin {
    name = "zen-browser-with-ffmpeg";
    paths = [ zenBase ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm $out/bin/zen
      makeWrapper ${zenBase}/bin/zen $out/bin/zen \
        --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [ pkgs.ffmpeg ]}
    '';
  };
in
{
  home.packages = [ zen ];
}
