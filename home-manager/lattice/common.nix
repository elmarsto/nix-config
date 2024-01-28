{ config, pkgs, lib, ... }:
{
  config = {
    home = {
      stateVersion = "23.11";
      activation.report-changes = config.lib.dag.entryAnywhere ''
        ${pkgs.nvd}/bin/nvd diff $oldGenPath $newGenPath
      '';
    };
    manual.html.enable = true;
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
