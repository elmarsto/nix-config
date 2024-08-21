{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    signal-desktop
    slack
    whatsapp-for-linux
    zoom-us
  ];
}

