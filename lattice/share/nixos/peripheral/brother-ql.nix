{ inputs, pkgs, ... }: let
  brother-ql = inputs.brother-ql.packages.x86_64-linux.default;
  #RESEARCH: doas rules for only sending to the given USB and nowhere lese
  bql = pkgs.writeScriptBin "bql" ''
   ${brother-ql}/bin/brother_ql -b pyusb -m QL-800 -p usb://0x04f9:0x209b print  -l 62 $@
   '';
in {
  environment.systemPackages = [
    brother-ql
    bql
  ];
}
