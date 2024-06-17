{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    fdk-aac-encoder
    ffmpeg-full
    #handbrake
    losslesscut-bin
    yt-dlp
    obs-cmd
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
    mimeApps.defaultApplications = {
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
    };
    desktopEntries.mpv = {
      name = "mpv";
      exec = "${pkgs.mpv}/bin/mpv %U";
      genericName = "Video and audio player";
      mimeType = [ "video/mp4" "video/x-matroska" "video/quicktime" ];
    };
  };
}
