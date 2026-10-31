# Filhanterare: PCManFM-Qt.
# Färgerna kommer från Noctalia via Qt-temat i theme/qt.nix.
# Att den är standard för mappar sätts på systemnivå i
# modules/nixos/desktop/integration.nix.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pcmanfm-qt
    lxqt.lxqt-archiver # packa upp/packa från högerklicksmenyn
    lxqt.lxqt-menu-data # programlistan i "Öppna med…"
    ffmpegthumbnailer # miniatyrer för video
  ];
}
