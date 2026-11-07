{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pcmanfm-qt
    lxqt.lxqt-archiver # packa upp/packa från högerklicksmenyn
    lxqt.lxqt-menu-data # programlistan i "Öppna med…"
    ffmpegthumbnailer # miniatyrer för video
  ];
}
