{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    lattice = ./lattice;
    repo = "github:elmarsto/nix-config";
    pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance

    ns = import ./nixos/configuration.nix;
    mk-app = p: {
      program = "${p}";
      type = "app";
    };
    mk-system = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs home-manager lattice repo;};
        modules = [
          (ns hostname)
        ];
      };
    hm = import ./home-manager/home.nix;
    mk-home = hostname:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs lattice repo;};
        modules = [
          (hm hostname)
        ];
      };

    host = pkgs.writeShellScript "host" ''
      echo .#`${pkgs.nettools}/bin/hostname`
    '';
    hms = pkgs.writeShellScript "flake-hms" ''
      ${pkgs.home-manager}/bin/home-manager switch --flake `${host}`
    '';
    nrs = pkgs.writeShellScript "flake-nrs" ''
      ${pkgs.doas}/bin/doas ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake `${host}`
    '';
    switch = pkgs.writeShellScript "flake-switch" ''
      ${hms}
      ${nrs}
    '';
  in {
    apps.x86_64-linux = {
      default = mk-app switch;
      nrs = mk-app nrs;
      hms = mk-app hms;
    };
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#hostname'
    nixosConfigurations = {
      fourcade = mk-system "fourcade";
      bowsprit = mk-system "bowsprit";
      sopwith = mk-system "sopwith";
    };
    # Available through 'home-manager --flake .#hostname'
    homeConfigurations = {
      fourcade = mk-home "fourcade";
      bowsprit = mk-home "bowsprit";
      sopwith = mk-home "sopwith";
    };
  };
}
