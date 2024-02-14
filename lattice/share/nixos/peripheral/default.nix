{ config, lib, pkgs, ... }: {
  imports = [
    ./brother-ql.nix
    ./rng.nix
    ./wacom.nix
    ./xbox.nix
    ./yubikey.nix
  ];
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint gutenprintBin espon-escpr hplip canon-cups-ufr2 ];
    browsing = true;
    allowFrom = ["all"];
    defaultShared = true;
  };
  hardware.sane = {
      openFirewall = true;
      enable = true;
      extraBackends = with pkgs; [ utsushi hplipWithPlugin sane-airscan ];
      brscan5.enable = true;
  };
}
