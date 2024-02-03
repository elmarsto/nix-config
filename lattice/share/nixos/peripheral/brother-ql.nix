{ inputs, pkgs, ... }: let
  bql = pkgs.writeScriptBin "bql" ''
   nix run github:elmarsto/brother-ql -b pyusb -m QL-800 -p usb://0x04f9:0x209b print -l 62 $@
   '';
in {
  environment.systemPackages = [
    bql
  ];
}
