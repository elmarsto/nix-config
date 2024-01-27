{ config, pkgs, lib, ... }:
{
  options.lattice.unstable = lib.mkOption { };
  config = {
    home = {
      stateVersion = "23.11";
      activation.report-changes = config.lib.dag.entryAnywhere ''
        ${pkgs.nvd}/bin/nvd diff $oldGenPath $newGenPath
      '';
    };
    manual.html.enable = true;
    lattice.unstable = import <nixos-unstable> { config.allowUnfree = true; };
    nixpkgs.config = {
      allowUnfree = true;
      nixpkgs.config.packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
    };
    programs = {
      home-manager.enable = true;
    };
  };
}
