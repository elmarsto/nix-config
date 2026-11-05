{pkgs, ...}: {
  home.packages = with pkgs; [
    ripgrep
    calibre
    foliate
  ];
  programs = {
    readline.enable = true;
  };
}
