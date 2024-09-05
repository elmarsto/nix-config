{...}: {
  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = true;
    };
    nvidia-container-toolkit.enable = true;
  };
  services = {
    xserver.videoDrivers = ["nvidia"];
    borgbackup.jobs.sopwith = {
      doInit = true;
      paths = ["/home/lattice"];
      repo = "fm1890@fm1890.rsync.net:sopwith";
      exclude = [
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
  networking = {
    hostName = "sopwith";
    hostId = "ea33110c"; # first 8 of /etc/machine-id, req for zfs
    networkmanager.enable = true;
    interfaces.wlp3s0.useDHCP = true;
  };
  imports = [./hardware-configuration.nix];
}
