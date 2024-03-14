{
  config,
  pkgs,
  lib,
  ...
}: let
  gitJust = pkgs.writeText "gitJust" ''
    [no-cd]
    default:
     git status

    [no-cd]
    blast msg='blast':
      git add .
      git commit -m '{{ msg }}'
      git pull -r
      git push
  '';
  # sorry not sorry
  Lustfile = pkgs.writeText "Lustfile" ''
    mod? l '~/.l/mod.just'
    mod git '${gitJust}'
    default:
      #!/usr/bin/env bash
      echo <<'EOF'
       ___
      |\  \
      \ \  \
       \ \  \
        \ \  \____
         \ \_______\
          \|_______|
      EOF
  '';
  L = pkgs.writeScriptBin "L" ''
    ${pkgs.just}/bin/just --unstable -d ~ -f ${Lustfile} "$@"
  '';
  git-L = pkgs.writeScriptBin "git-L" ''
    ${L}/bin/L git "$@"
  '';
  l = pkgs.writeScriptBin "l" ''
    ${L}/bin/L l "$@"
  '';
  git-l = pkgs.writeScriptBin "git-l" ''
    ${l}/bin/l git "$@"
  '';
in {
  home = {
    packages = [L l git-L git-l];
  };
  programs.bash.initExtra = ''
    export JUST_UNSAFE=1
    unalias l
  '';
}
