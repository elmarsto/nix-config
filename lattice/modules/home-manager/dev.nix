{ lib, config, pkgs, ... }:
let
  termPkgs = with pkgs; [
    # android-studio
    # autoconf
    # automake
    # boost
    # clang
    # cmake
    # comby
    # gnumake
    # hexyl
    # iperf
    # just
    # netperf
    # ngrok
    # ninja
    # perf-tools
    # valgrind
  ];

  guiPkgs = with pkgs; [
    #godot
    # hotspot
    # qcachegrind
    #love
  ];

in
{
  imports = [ ./vscode.nix ];
  config.home.packages = if config.lattice.gui.enable then termPkgs ++ guiPkgs else termPkgs;
}

