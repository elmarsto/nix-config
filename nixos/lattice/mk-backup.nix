{ lib, repo, passCommand }:  let 
  exclude = [
    "**/$RECYCLE.BIN"
    "**/*.bak"
    "**/*.o"
    "**/*.part"
    "**/*.swo"
    "**/*.swp"
    "**/*.tmp" 
    "**/*~"
    "**/.Cache"
    "**/.DS_Store"
    "**/.Trashes"
    "**/.bzr"
    "**/.cache2"
    "**/.git"
    "**/.hg"
    "**/.mozilla"
    "**/.pijul"
    "**/.snapshots"
    "**/.stfolder"
    "**/.thunderbird"
    "**/.trashed"
    "**/.venv"
    "**/_build"
    "**/backed-up-elsewhere"
    "**/node_modules"
    "**/out"
    "**/result"
    "**/venv"
    "/bin"
    "/boot"
    "/boot"
    "/dev"
    "/home/*/.cache"
    "/home/*/.cargo"
    "/home/*/.config/Code/CachedData"
    "/home/*/.config/Slack/logs"
    "/home/*/.local/share/Trash"
    "/home/*/.local/share/nvim"
    "/home/*/.local/state"
    "/home/*/.npm"
    "/home/*/.rustup"
    "/home/*/Downloads"
    "/home/*/go"
    "/lib"
    "/lib64"
    "/mnt"
    "/nix"
    "/proc"
    "/run"
    "/sys"
    "/tmp"
    "/usr/bin"
    "/usr/lib"
    "/usr/lib64"
    "/var/cache"
    "/var/lock"
    "/var/run"
    "/var/tmp"
  ];
  merge = import ./recursive-merge.nix { lib = lib; };
  prot = {
    exclude = exclude;
    encryption = {
      mode = "repokey-blake2";
      passCommand = passCommand;
    };
    inhibitsSleep = true;
    startAt = "daily";
  };
  mkBackup = name: rest: let
    prototype = prot // { repo = "${repo}/${name}"; };
  in { ${name} = merge [ prototype rest ]; };
in mkBackup
    
