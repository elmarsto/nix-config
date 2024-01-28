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
  termPkgs = with pkgs; [
    #aspell
    #cmark
    #dict
    #epr
    #fop
    #glow
    joplin
    #marksman
    #mdbook
    #mdbook-mermaid
    #pdfarranger
    #pdftk
    #poppler_utils
    ripgrep
    ruplacer
    #sad
    #sd
    #scowl
    #unicode-character-database
    #unicode-paracode
    #unipicker
    #unrtf
    #wordnet
    #vale
  ];
  guiPkgs = with pkgs; [
    #anki
    calibre
    #sigil
    foliate
    #fontpreview
    joplin-desktop
    write_stylus
  ];
in
{
  imports = [ ./neovim.nix ];

  home.packages = if config.lattice.gui.enable then termPkgs ++ guiPkgs else termPkgs;
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
