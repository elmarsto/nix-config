# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
hostname: {
  config,
  lattice,
  lib,
  outputs,
  pkgs,
  repo,
  unstable,
  ...
}: {
  imports = [
    (lattice + /sys/${hostname}/home.nix)
    (lattice + /share/home-manager)
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
  };
  home = {
    activation.report-changes = config.lib.dag.entryAnywhere ''
      ${pkgs.nvd}/bin/nvd diff $oldGenPath $newGenPath
    '';
    packages = with pkgs; [
      (pkgs.writeScriptBin "lattice-hms" ''
        home-manager switch --flake ${repo}#${hostname} --refresh $@
      '')
      cachix
      manix
      nix-doc
      nurl
    ];
    stateVersion = "24.11";
  };
  manual.html.enable = true;
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
  };
  systemd.user.startServices = "sd-switch";
}
