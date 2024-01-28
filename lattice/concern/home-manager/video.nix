{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    fdk-aac-encoder
    ffmpeg-full
    yt-dlp
    handbrake
    losslesscut-bin
  ];
  programs = {
    mpv.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-multi-rtmp
        looking-glass-obs
      ];

    };
  };
  xdg = {
    mimeApps = {
      defaultApplications = {
        "video/mp4" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "video/quicktime" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
      };
    };
    desktopEntries = {
      mpv = {
        name = "mpv";
        genericName = "Video and audio player";
        exec = "${pkgs.mpv}/bin/mpv %U";
        mimeType = [ "video/mp4" "video/x-matroska" "video/quicktime" ];
      };
    };
  };
}
