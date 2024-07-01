{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    element-desktop
    signal-desktop
    slack
    whatsapp-for-linux
    zoom-us
  ];
}

