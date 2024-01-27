
{ lib, ... }: 
let
  mkBackup = import ./mk-backup.nix {
    lib = lib;
    repo = "nope@localhost:/tmp";
    passCommand = "/etc/secrets/borgbackup.sh";
  };
in
{
  imports = [ ./backup.nix ]; # TODO: passthru somehow? too sleepy
  services = {
    borgbackup.jobs = mkBackup "fourcade" { paths = ["/rheic"]; };
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
