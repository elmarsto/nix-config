{
  config,
  pkgs,
  lib,
  lattice,
  ...
}: let
in {
  services = {
    btrbk = {
      ioSchedulingClass = "idle";
      niceness = 19;
      instances.btrbk = {
        onCalendar = null;
        settings = {
          snapshot_preserve = "14d";
          snapshot_preserve_min = "2d";
        };
      };
    };
  };
}
