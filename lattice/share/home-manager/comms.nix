{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    element-desktop
    signal-desktop
    slack
  ];
}

