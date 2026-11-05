{
  config,
  pkgs,
  lib,
  ...
}: {
  programs = {
    mpv.enable = true;
  };
  xdg = {
    mimeApps.defaultApplications = {
      "video/mp4" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
      "video/quicktime" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
    };
    desktopEntries.mpv = {
      name = "mpv";
      exec = "${pkgs.mpv}/bin/mpv %U";
      genericName = "Video and audio player";
      mimeType = ["video/mp4" "video/x-matroska" "video/quicktime"];
    };
  };
}
