{
  outputs = { self, nixpkgs }: {
    nixosConfigurations.fourcade = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.fourcade.nix ];
    };
  };
}
