{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    #discord
    #telegram-desktop
    signal-desktop
    #slack
    zoom-us
  ];
}

