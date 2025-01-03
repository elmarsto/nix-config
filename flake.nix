{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
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
      "aarch64-darwin"
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    lattice = ./lattice;
    repo = "github:elmarsto/nix-config";
    x64LinuxPkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
    aarch64DarwinPkgs = nixpkgs.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance

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
    mk-home = hostname: pkgs:
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = {inherit inputs outputs lattice repo;};
        modules = [
          (hm hostname)
        ];
      };

    host = x64LinuxPkgs.writeShellScript "host" ''
      echo .#`${x64LinuxPkgs.nettools}/bin/hostname`
    '';
    hms = x64LinuxPkgs.writeShellScript "flake-hms" ''
      ${x64LinuxPkgs.home-manager}/bin/home-manager switch --flake `${host}`
      ${x64LinuxPkgs.nix-index}/bin/nix-index
    '';
    nrs = x64LinuxPkgs.writeShellScript "flake-nrs" ''
      ${x64LinuxPkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake `${host}`
      ${x64LinuxPkgs.nix}/bin/nix-channel --update
    '';
    switch = x64LinuxPkgs.writeShellScript "flake-switch" ''
      doas ${nrs}
      ${hms}
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
      pamplemoose = mk-system "pamplemoose";
    };
    # Available through 'home-manager --flake .#hostname'
    homeConfigurations = {
      fourcade = mk-home "fourcade" x64LinuxPkgs;
      bowsprit = mk-home "bowsprit" x64LinuxPkgs;
      sopwith = mk-home "sopwith" x64LinuxPkgs;
      pamplemoose = mk-home "pamplemoose" aarch64DarwinPkgs;
    };
  };
}
