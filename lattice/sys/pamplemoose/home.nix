{lattice, ...}: {
  imports = [
    (lattice + /share/home-manager/neovim)
    (lattice + /share/home-manager/shell)
    (lattice + /share/home-manager/visual.nix)
    (lattice + /share/home-manager/text.nix)
    (lattice + /share/home-manager/vcs.nix)
  ];
  home = {
    username = "elizabeth.marston";

    homeDirectory = "/Users/elizabeth.marston";
  };
}
