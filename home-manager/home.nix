# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
hostname: {
  config,
  inputs,
  lattice,
  lib,
  outputs,
  pkgs,
  repo,
  unstable,
  ...
}: {
  imports = [
    (lattice + /sys/${hostname}/home)
    (lattice + /share/home-manager)
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
    packages = [
      (pkgs.writeScriptBin "lattice-hms" ''
        home-manager switch --flake ${repo}#${hostname}
      '')
    ];
  };
  manual.html.enable = true;
  programs = {
    home-manager.enable = true;
  };
}
