{ config, pkgs, lib, ... }:
let
  screencastRecorder = config.lattice.video.screen.recorder;
  termPkgs = with pkgs; [
    fdk-aac-encoder
    ffmpeg-full
    #gifski
    yt-dlp
  ];
  guiPkgs = with pkgs; [
    handbrake
    #hugin
    losslesscut-bin
    #config.lattice.unstable.pitivi
  ];
in
{
  #TODO: move all other options in all other files into namespaced sections under lattice.*
  options.lattice.video = {
    screen = {
      recorder = lib.mkOption {
        type = lib.types.path;
      };
      capture = lib.mkOption {
        type = lib.types.path;
      };
    };
  };
  config = {
    home.packages = if config.lattice.gui.enable then termPkgs ++ guiPkgs else termPkgs;
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
  };
}
