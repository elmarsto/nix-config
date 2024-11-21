{
  config,
  pkgs,
  lib,
  ...
}: let
  gitJust = pkgs.writeText "gitJust" ''
    just := 'L git'
    code := '~/code'
    quandri := '{{code}}/quandri'
    ours := '{{code}}/ours'
    navaruk := '~/navaruk'
    liz-notes := '{{quandri}}/liz-second-brain'
    qcr-api := '{{quandri}}/control-room-api'
    nix-config := '{{ ours }}/nix-config'

    [no-cd]
    default:
     git status

    [no-cd]
    blast msg='blast':
      git add .
      git commit -m '{{ msg }}'
      git pull -r
      git push

    _eod repo:
      pushd {{ repo }}
      git pull
      git add .
      git commit -am 'eod'
      git push
      git co -
      popd

    eod:
      {{ just }} _eod  {{ navaruk }}
      {{ just }} _eod  {{ liz-second-brain }}
      {{ just }} _eod  {{ qcr-api }}
      {{ just }} _eod  {{ nix-config }}

  '';
  # sorry not sorry
  Lustfile = pkgs.writeText "Lustfile" ''
    just := 'L'
    today := `date +%F`
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

      eod:
        {{ L }} git eod


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
  git-hub = pkgs.writeScriptBin "git-hub" ''
    ${pkgs.git}/bin/git clone "git@github.com:$1"
  '';
in {
  home = {
    packages = [L l git-L git-l git-hub];
    file.l = {
      recursive = true;
      source = ./l;
      target = ".l";
    };
  };
  programs.bash.initExtra = ''
    export JUST_UNSAFE=1
    unalias l 2>/dev/null
  '';
}
