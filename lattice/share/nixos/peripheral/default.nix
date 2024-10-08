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
    drivers = with pkgs; [gutenprint gutenprintBin epson-escpr epson-escpr2 canon-cups-ufr2];
    browsing = true;
    allowFrom = ["all"];
    defaultShared = true;
  };
  hardware = {
    bluetooth.enable = true;
    sane = {
      openFirewall = true;
      enable = true;
      extraBackends = with pkgs; [utsushi sane-airscan];
      brscan5.enable = true;
    };
  };
}
