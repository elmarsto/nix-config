{
  lib,
  lattice,
  ...
}: let
  mkBackup = import (lattice + /share/util/mk-backup.nix) {
    lib = lib;
    repo = "nope@localhost:/tmp";
    passCommand = "/etc/secrets/borgbackup.sh";
  };
in {
  services = {
    borgbackup.jobs = {
      fourcade = {
        doInit = true;
        paths = ["/home/lattice" "/rheic"];
        repo = "fm1890@fm1890.rsync.net:fourcade";
        exclude = [
          "/rheic/backed-up-elsewhere"
          "**/.cache"
          "/home/lattice/code"
          "/home/lattice/Downloads"
          "/home/lattice/.mozilla"
        ];
        encryption = {
          mode = "repokey-blake2";
          passCommand = "cat /etc/secrets/borgbackup-rsync.net";
        };
        environment = {
          BORG_RSH = "ssh -i /etc/secrets/id_rsync.net";
        };
        compression = "auto,lzma";
        startAt = "hourly";
      };
    };
    btrbk.instances = {
      thallas.settings = {
        volume = {
          "/rheic" = {
            group = "thallas";
            #TODO: see if this can be replaced with symlink which does not contain username e.g. /thallas. reason: shameless aesthetics
            target = "/run/media/lattice/thallas";
            snapshot_dir = ".snapshots";
            subvolume = {
              "lattice" = {
                snapshot_create = "always";
              };
              "too-many-secrets" = {
                snapshot_create = "always";
              };
              "backed-up-elsewhere" = {
                snapshot_create = "always";
              };
            };
          };
        };
      };
      iapetus.settings = {
        volume = {
          "/rheic" = {
            group = "iapetus";
            # TODO: ibid.
            target = "/run/media/lattice/iapetus";
            snapshot_dir = ".snapshots";
            subvolume = {
              "lattice" = {
                snapshot_create = "always";
              };
              "too-many-secrets" = {
                snapshot_create = "always";
              };
              "backed-up-elsewhere" = {
                snapshot_create = "always";
              };
            };
          };
        };
      };
    };
  };
}
