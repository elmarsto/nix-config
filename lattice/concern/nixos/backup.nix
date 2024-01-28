{ config, pkgs, lib, lattice, ... }: let
  mkBackup = import (lattice + /util/mk-backup.nix) { inherit lib; repo = "lattice@localhost:/tmp/"; passCommand = "/etc/secrets/borgbackup.sh"; };
in {
  services = {
    borgbackup.jobs = mkBackup "system" {
      paths = [ "/etc" "/opt" "/usr/local" "/root" ];
      startAt = "monthly";
    } // 
    mkBackup "user" {
      paths = [ "/home" "/var/backup" "/var/spool" ];
    };
    btrbk = {
      ioSchedulingClass = "idle";
      niceness = 19;
      extraPackages = [ pkgs.xz ];
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
