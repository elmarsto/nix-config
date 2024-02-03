{ pkgs, ... }: let
  bql = pkgs.writeScriptBin "bql" ''
    nix run github:elmarsto/brother-ql -- -m QL-800 -b pyusb -p usb://0x04f9:0x209b $@
   '';
  bql-p = pkgs.writeScriptBin "bql" ''
    ${bql} print -l 62 $@
   '';
  doasRule = cmd: {
    cmd = "${cmd}";
    groups = [ "wheel" ];
    noPass = true;
  };
in {
  environment.systemPackages = [ bql bql-p ];
  security.doas.extraRules = builtins.map doasRule [bql bql-p];
}
