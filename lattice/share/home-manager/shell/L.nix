{pkgs, ...}: let
  # sorry not sorry
  Lustfile = pkgs.writeText "Lustfile" ''
    just := 'L'
    today := `date +%F`

    [private]
    @default:
      L --list

    @svgify:
      
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
