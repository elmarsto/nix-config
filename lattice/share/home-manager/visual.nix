{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    cheese
    darktable
    exif
    exiv2
    gimp
    imagemagick
    inkscape
    krita
    libheif
  ];
}
