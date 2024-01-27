{ pkgs, config, ... }: {
  imports = [
    ./epson.nix
    ./razer.nix
    ./wacom.nix
    ./xbox.nix
    ./yubikey.nix
  ];
}
