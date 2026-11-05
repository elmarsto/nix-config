{pkgs, ...}: {
  home.packages = with pkgs; [
    mpv
  ];
  xdg = {
    mimeApps = {
      defaultApplications = {
        "audio/mpeg" = ["mpv.desktop"];
        "audio/wav" = ["mpv.desktop"];
      };
    };
    # desktopEntries = {
    #   mpv = {
    #     mimeType = ["audio/mpeg" "audio/wav"];
    #   };
    # };
  };
}
