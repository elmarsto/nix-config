{pkgs, ...}: let
  # sorry not sorry
  Lustfile = pkgs.writeText "Lustfile" ''
    just := 'L'
    today := `date +%F`

    [private]
    @default:
      L --list

    @a *options:
      asciinema {{ options }}

    @svgcast file:
      #!/usr/bin/env bash
      set -xe

      TMP=$(mktemp)
      TMP2=$(mktemp)
      asciinema rec "$TMP" -c "bash -l"
      asciinema convert -f asciicast-v2 "$TMP" "$TMP2"
      cat "$TMP2" | node /home/lattice/code/theirs/svg-term-cli/lib/cli.js > {{file}}
      rm "$TMP"
      rm "$TMP2"


  '';
  L = pkgs.writeScriptBin "L" ''
    ${pkgs.just}/bin/just --unstable -d ~ -f ${Lustfile} "$@"
  '';
in {
  home = {
    packages = [L];
  };
  programs.bash.initExtra = ''
    export JUST_UNSAFE=1
  '';
}
