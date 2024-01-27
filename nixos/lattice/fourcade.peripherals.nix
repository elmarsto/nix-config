{ pkgs, config, ... }: {
  imports = [
    ./epson.nix
    ./razer.nix
    ./rng.nix
    ./wacom.nix
    ./xbox.nix
    ./yubikey.nix
  ];
}
