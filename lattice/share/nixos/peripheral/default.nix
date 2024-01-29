{ config, lib, pkgs, ... }: {
  imports = [
    ./epson.nix
    ./razer.nix
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
