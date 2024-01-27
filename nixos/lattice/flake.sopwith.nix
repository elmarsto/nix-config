{
  outputs = { self, nixpkgs }: {
    nixosConfigurations.bowsprit = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.sopwith.nix ];
    };
  };
}
