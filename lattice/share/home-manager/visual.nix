{pkgs, ...}: {
  home.packages = with pkgs; [
    darktable
    exif
    exiv2
    gimp
    graphviz
    imagemagick
    inkscape-with-extensions
    libheif
  ];
}
