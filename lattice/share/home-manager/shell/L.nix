{
  config,
  pkgs,
  lib,
  ...
}: let
  # sorry not sorry
  Lustfile = pkgs.writeText "lattice-Lustfile" ''
    default:
      echo "works!"
      echo `pwd`
  '';
  L = pkgs.writeScriptBin "L" ''
    ${pkgs.just}/bin/just --unsafe -f ${Lustfile} -d ~
  '';
in {
  home = {
    packages = [L];
  };
  programs.bash.initExtra = ''
    export JUST_UNSAFE=1
  '';
}
