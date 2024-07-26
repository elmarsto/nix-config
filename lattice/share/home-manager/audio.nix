{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    castget
    mpv
    sayonara
    spotify
    reaper
  ];
  xdg = {
    mimeApps = {
      defaultApplications = {
        "audio/mpeg" = ["mpv.desktop"];
        "audio/wav" = ["mpv.desktop"];
      };
    };
    desktopEntries = {
      mpv = {
        mimeType = ["audio/mpeg" "audio/wav"];
      };
    };
  };
}
