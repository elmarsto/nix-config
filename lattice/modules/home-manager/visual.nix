{ config, pkgs, ... }:
let
  termPkgs = with pkgs; [
    exif
    exiv2
    imagemagick
    libheif # heif-convert, needed to handle iphone pics
  ];
  guiPkgs = with pkgs; [
    darktable
    figma-linux
    gimp
    graphviz
    krita
    inkscape-with-extensions
  ];
  headlessPkgs = with pkgs; [
    ghostscript_headless # needed by imageMagick among others
    graphviz-nox
  ];
in
{
  home.packages =
    if config.lattice.gui.enable
    then termPkgs ++ guiPkgs
    else termPkgs ++ headlessPkgs;
}
