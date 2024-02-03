{ config, lib, pkgs, ... }: {
  imports = [
    ./brother-ql.nix
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
