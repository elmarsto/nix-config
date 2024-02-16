{ config, lib, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      meld
      git-interactive-rebase-tool
      git-lfs
      gitui
      hub
    ];
    sessionVariables = {
      GIT_PAGER = "delta";
    };
  };
  programs = {
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
    git = {
      aliases = {
        c  = "commit";
        co = "checkout";
        m  = "merge";
        p  = "pull";
        P  = "push";
        r  = "rebase";
        s  = "switch";
      };
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      lfs.enable = true;
      delta.enable = true;
      userName = "Elizabeth Marston";
      userEmail = "315987+elmarsto@users.noreply.github.com";
      ignores = [
        " .stignore"
        "*.secret"
        "*.stversions"
        "*.swo"
        "*.swp"
        "*~"
        ".DS_STORE/"
        ".stfolder/"
        ".stignore"
        ".stversions/"
        ".trash/"
        ".*trashed"
      ];
      includes = [
        { condition = "gitdir:~/code/quandri"; contents.user = { email = "elizabeth.marston@quandri.io"; }; }
      ];
      extraConfig = {
        branch.sort = "committerdate";
        commit.verbose = true;
        credential.helper = "libsecret";
        diff = {
          algorithm = "histogram";
          context = 10;
          submodule = "log";
          tool = "nvimdiff";
        };
        difftool = {
          prompt = true;
          nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        };
        fetch = {
          fsckobjects = true;
          prune = true;
          prunetags = true;
        };
        global.sequence.editor = "${pkgs.git-interactive-rebase-tool}/bin/interactive-rebase-tool";
        init.defaultbranch = "main";
        log.date = "iso";
        merge = {
          conflictstyle = "zdiff3";
          tool = "meld";
        };
        pull.ff = "only";
        push = {
          autosetupremote = true;
          default = "current";
          followtags = true;
        };
        rebase = {
          autosquash = true;
          autostash = true;
        };
        receive.fsckobjects = true;
        rerere.enabled = true;
        status.submodulesummary = true;
        submodule.recurse = true;
        tag.sort = "taggerdate";
        transfer.fsckobjects = true;
      };
      signing = {
        key = null; # let GPG choose based on email address
        signByDefault = true;
      };
    };
  };
}
