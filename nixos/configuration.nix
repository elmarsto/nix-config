# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
hostname: {
  inputs,
  outputs,
  lib,
  config,
  lattice,
  repo,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    (lattice + /sys/${hostname}/configuration)
    (lattice + /share/nixos)
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
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
        nixos-rebuild switch --flake ${repo}#${hostname}
      '')
    ];
  };
  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

}
