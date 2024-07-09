{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    cheese
    darktable
    exif
    exiv2
    figma-linux
    gimp
    graphviz
    imagemagick
    inkscape-with-extensions
    krita
    libheif
  ];
}
