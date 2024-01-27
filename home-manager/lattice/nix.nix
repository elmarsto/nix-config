{ config, pkgs, ... }:
let
  unstable = config.lattice.unstable;
  termPkgs = with pkgs; [
    cachix
    comma
    manix
    #nix-diff
    nix-doc
    #nix-du
    #nix-melt
    #nix-pin
    #nix-prefetch
    #nix-prefetch-git
    #nix-prefetch-github
    #nix-top
    #nix-tree
    #nix-update
    nurl
  ];
  guiPkgs = with pkgs; [ ];
in
{
  home.packages = if config.lattice.gui.enable then termPkgs ++ guiPkgs else termPkgs;
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
  };
  services = {
    lorri.enable = true;
  };
}
