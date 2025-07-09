{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    telegram-desktop
    signal-desktop
    slack
    whatsapp-for-linux
    zoom-us
  ];
}

