{ lib, config, pkgs, ... }:
let
  unstable = config.lattice.unstable;
in
{
  programs.vscode = if !config.lattice.gui.enable then { } else {
    enable = false;
    package = unstable.vscode;
  };
  # xdg = if !config.programs.vscode.enable then { } else {
  #   mimeApps = {
  #     defaultApplications = {
  #       "application/vnd" = [ "code.desktop" ]; # jupyter notebook
  #       "application/x-code-insiders-workspace" = [ "code.desktop" ];
  #       "application/x-code-workspace" = [ "code.desktop" ];
  #     };
  #   };
  #   desktopEntries = {
  #     code = {
  #       name = "Visual Studio Code";
  #       genericName = "VSC";
  #       exec = "${config.programs.vscode.package}/bin/code %U";
  #       mimeType = [
  #         "application/vnd"
  #         "application/x-code-insiders-workspace"
  #         "application/x-code-workspace"
  #       ];
  #     };
  #   };
  # };
}

