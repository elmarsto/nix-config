{ config, pkgs, lib, ... }:
let
  unstable = config.lattice.unstable;
  #reaperDir = ../reaper-config;
in
{
  # options = {
  #   lattice.audio = {
  #     enable = lib.mkOption {
  #       type = lib.types.bool;
  #       description = "audio support?";
  #     };
  #   };
  # };
  config = {
    home.packages = with pkgs; [
      #audacity
      #carla
      castget
      #cmus
      #cozy
      #gnome-podcasts
      #greg
      #id3v2
      #libsForQt5.kasts
      #mp3info
      #mpg123
      mpv
      #patchage
      #pavucontrol
      sayonara
      #soundconverter
      #spot
      spotify
      #unstable.reaper
      #yabridge
      #yabridgectl
    ];
    #programs.beets.enable = true;
    xdg = {
      # configFile.reaper = {
      #   source = reaperDir;
      #   target = "REAPER";
      #   recursive = true;
      # };
      mimeApps = {
        defaultApplications = {
          "audio/mpeg" = [ "mpv.desktop" ];
          "audio/wav" = [ "mpv.desktop" ];
        };
      };
      desktopEntries = {
        mpv = {
          mimeType = [ "audio/mpeg" "audio/wav" ];
        };
      };
    };
  };
}
