{pkgs, ...}: let
  mdMime = pkgs.writeText "text-markdown.xml" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
      <mime-type type="text/markdown">
        <comment>Markdown</comment>
        <glob pattern="*.md"/>
      </mime-type>
    </mime-info>
  '';
in {
  home.packages = with pkgs; [
    #joplin
    ripgrep
    ruplacer
    calibre
    foliate
    glow
    #joplin-desktop
  ];
  programs = {
    fzf.enable = true;
    readline.enable = true;
    skim.enable = true;
    helix = {
      enable = true;
      settings = {
        theme = "base16";
      };
    };
  };
  xdg = {
    dataFile."mime/packages/text-markdown.xml".source = mdMime;
    desktopEntries = {
      glow = {
        name = "Glow";
        genericName = "Markdown previewer";
        exec = ''${pkgs.alacritty}/bin/alacritty -e "${pkgs.glow}/bin/glow %U"'';
        mimeType = ["text/markdown"];
      };
    };
  };
}
