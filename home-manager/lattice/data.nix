{ config, pkgs, ... }:
let
  guiPkgs = with pkgs; [ ];
  termPkgs = with pkgs; [
    #datasette
    #gnumeric
    #hledger
    ##hledger-ui
    #htmlq
    #jo
    #jq
    #jql
    #litecli
    #miller
    #mycli
    #rqlite
    #sqlite-utils
    #tv
    #visidata
    #xsv
    #yq
  ];
in
{
  home.packages = if config.lattice.gui.enable then termPkgs ++ guiPkgs else termPkgs;
}
