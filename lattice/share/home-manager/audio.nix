{pkgs, ...}: {
  home.packages = with pkgs; [
    mpv
    tidal-hifi
    tidal-dl
    kdePackages.kasts
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
