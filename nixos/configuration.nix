hostname: {
  inputs,
  outputs,
  lib,
  config,
  lattice,
  repo,
  pkgs,
  ...
}: let
  args = ["switch" "--flake" "${repo}#${hostname}" "--refresh"];
  cmd = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
in {
  imports = [
    (lattice + /sys/${hostname}/configuration)
    (lattice + /share/nixos)
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.nixPath = ["/etc/nix/path"];
  environment = {
    etc =
      lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;
    systemPackages = [
      (pkgs.writeScriptBin "lattice-nrs" ''
        doas ${cmd} ${builtins.concatStringsSep " " args}
      '')
    ];
  };
  security.doas.extraRules = [{ inherit cmd args; noPass = true; }];
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

}
