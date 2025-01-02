{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./brother-ql.nix
    ./rng.nix
    ./wacom.nix
    ./xbox.nix
    ./yubikey.nix
  ];

  environment.systemPackages = with pkgs; [
    footswitch
  ];
  services.printing = {
    enable = true;
    drivers = with pkgs; [gutenprint gutenprintBin];
    browsing = true;
    allowFrom = ["all"];
    defaultShared = true;
  };
  hardware = {
    bluetooth.enable = true;
  };
}
