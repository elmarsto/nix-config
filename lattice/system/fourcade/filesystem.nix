{ config, lib, pkgs, modulesPath, ... }: {
  boot = {
    initrd = {
       luks.devices."nixos".device = "/dev/disk/by-uuid/01768c6c-055f-4a89-bcc1-f6a6803c756c";
       supportedFilesystems = ["nfs"];
    };
    supportedFilesystems = ["nfs"];
  };
  services = {
    udev.extraRules = ''
       ACTION=="add|change", KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="zfs_member", ATTR{../queue/scheduler}="none"
    '';
  };
  fileSystems."/" =
    { device = "/dev/mapper/nixos";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F1BE-D27C";
      fsType = "vfat";
      options = [ "noatime" ];
    };
  fileSystems."/hugepages-2MiB" =
    { device = "hugetlbfs";
    fsType = "hugetlbfs";
    options = [ "mode=1770"  "gid=0" "pagesize=2MiB"];
    };
  fileSystems."/hugepages-1GiB" =
    { device = "hugetlbfs";
    fsType = "hugetlbfs";
    options = [ "mode=1770"  "gid=0" "pagesize=1GiB"];
    };
  fileSystems."/rheic" =
   {  device = "/dev/mapper/rheic";
      fsType = "btrfs";
      options = [ "noatime" "ssd"  "discard=async"  "space_cache=v2"  "compress=zstd:3"];
      encrypted = {
        enable = true;
        blkDev = "/dev/disk/by-uuid/f54efe25-4ae9-41be-b5e0-10a6fe73eb08";
        label = "rheic";
      };
   };
  swapDevices =
    [ { device = "/dev/disk/by-uuid/a16094b4-9c13-4624-a521-ca439dc328ec"; }
    ];
  environment.shellAliases = {
    mount-witch = "mount -o offset=$((512*32768)) /var/lib/libvirt/images/witch.img  /witch";
  };
  services.btrfs.autoScrub.enable = true;
}
