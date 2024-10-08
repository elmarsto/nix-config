{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    #joplin
    ripgrep
    ruplacer
    #calibre
    #foliate
    glow
    #joplin-desktop
    #write_stylus
  ];
  programs = {
    fzf.enable = true;
    readline.enable = true;
    skim.enable = true;
  };
}
