{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    exif
    exiv2
    imagemagick
    libheif
    darktable
    figma-linux
    gimp
    graphviz
    krita
    inkscape-with-extensions
  ];
}
