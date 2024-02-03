{ pkgs, ... }: let
  bql = pkgs.writeScript "bql" ''
    nix run github:elmarsto/brother-ql -- -m QL-800 -b pyusb -p usb://0x04f9:0x209b $@
   '';
  bql-p = pkgs.writeScript "bql-p" ''
    ${bql} print -l 62 $@
  '';

  brother-ql = pkgs.writeScriptBin "brother-ql" ''
    doas ${bql} $@
  '';
  brother-ql-print = pkgs.writeScriptBin "brother-ql-print" ''
    doas ${bql-p} $@
  '';

  doasRule = exe: {
    cmd = "${exe}";
    groups = [ "wheel" ];
    noPass = true;
  };
in {
  environment.systemPackages = [ brother-ql brother-ql-print ];
  security.doas.extraRules = builtins.map doasRule [bql bql-p];
}
