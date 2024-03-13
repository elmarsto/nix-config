{
  config,
  pkgs,
  lib,
  ...
}: let
  gitJust = pkgs.writeText "gitJust" ''
    [no-cd]
    default:
      ${pkgs.git}/bin/git status
  '';
  # sorry not sorry
  Lustfile = pkgs.writeText "Lustfile" ''
    mod? l '~/.l/mod.just'
    mod git '${gitJust}'
    default:
      echo `pwd`
  '';
  L = pkgs.writeScriptBin "L" ''
    ${pkgs.just}/bin/just --unstable -d ~ -f ${Lustfile} "$@"
  '';
  git-L = pkgs.writeScriptBin "git-L" ''
    ${L}/bin/L git "$@"
  '';
in {
  home = {
    packages = [L git-L];
  };
  programs.bash.initExtra = ''
    export JUST_UNSAFE=1
  '';
}
