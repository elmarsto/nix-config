{ config, pkgs, ... }:
let
  termPkgs = with pkgs; [
    #fractal
    #jitsi-meet
    #matrix-commander
    #matrixcli
  ];
  guiPkgs = with pkgs; [
    #discord
    element-desktop
    #jitsi-meet-electron
    signal-desktop
    slack
    #zoom-us
  ];
in
{
  home.packages = if config.lattice.gui.enable then termPkgs ++ guiPkgs else termPkgs;
}

