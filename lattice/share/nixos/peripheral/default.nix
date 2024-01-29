{ config, lib, pkgs, ... }: {
  imports = [
    ./epson.nix
    ./rng.nix
    ./wacom.nix
    ./xbox.nix
    ./yubikey.nix
  ];
  services.printing = {
     enable = true;
     drivers = [ pkgs.gutenprint pkgs.gutenprintBin ];
  };
}
