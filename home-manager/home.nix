# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
hostname: {
  config,
  inputs,
  lattice,
  lib,
  outputs,
  pkgs,
  unstable,
  ...
}: {
  imports = [
    (lattice + /system/${hostname}/home.nix)
    (lattice + /share/home-manager.nix)
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
  systemd.user.startServices = "sd-switch";
  home = {
    stateVersion = "23.11";
    activation.report-changes = config.lib.dag.entryAnywhere ''
      ${pkgs.nvd}/bin/nvd diff $oldGenPath $newGenPath
    '';
  };
  manual.html.enable = true;
  programs = {
    home-manager.enable = true;
  };
}
