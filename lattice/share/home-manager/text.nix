{ config, pkgs, ... }:
let
  mdMime = pkgs.writeText "text-markdown.xml" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
      <mime-type type="text/markdown">
        <comment>Markdown</comment>
        <glob pattern="*.md"/>
      </mime-type>
    </mime-info>
  '';
in
{
  home.packages = with pkgs; [
    joplin
    ripgrep
    ruplacer
    calibre
    foliate
    joplin-desktop
    write_stylus
  ];
  programs = {
    fzf.enable = true;
    pandoc = {
      enable = true;
      defaults = {
        metadata = {
          author = "Elizabeth Marston";
        };
      };
    };
    readline.enable = true;
    skim.enable = true;
  };
  xdg = {
    mimeApps = {
      defaultApplications = {
        "text/markdown" = [ "firefox.desktop" ];
      };
    };
    dataFile."mime/packages/text-markdown.xml".source = mdMime;
    desktopEntries = {
      glow = {
        name = "Glow";
        genericName = "Markdown previewer";
        exec = ''${pkgs.alacritty}/bin/alacritty -e "${pkgs.glow}/bin/glow %U"'';
        mimeType = [ "text/markdown" ];
      };
    };
  };
}
