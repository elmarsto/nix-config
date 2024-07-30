{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      meld
      git-interactive-rebase-tool
      git-lfs
      git-cliff
      gitui
      hub
      pijul
    ];
    sessionVariables = {
      GIT_PAGER = "delta";
    };
  };
  programs = {
    bash.initExtra = ''
      export JUST_UNSAFE=1
      GIT_PAGER='delta';
      alias g='git';
    '';
    # gh = {
    #   enable = true;
    #   settings = {
    #     git_protocol = "ssh";
    #   };
    # };
    git = {
      aliases = {
        c = "commit";
        co = "checkout";
        m = "merge";
        p = "pull";
        P = "push";
        r = "rebase";
        wt = "worktree";
        s = "switch";
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
      # includes = [
      #   {
      #     condition = "gitdir:~/code/quandri/**/*";
      #     contents.user = {
      #       email = "elizabeth.marston@quandri.io";
      #       signingKey = "63FB C302 8ECE 1230 8062 BA09 4FF0 F4F0 B516 693E";
      #     };
      #   }
      #   {
      #     condition = "gitdir:~/navaruk";
      #     contents.user = {
      #       email = "her@lizmars.net";
      #       signingKey = "B8DF C273 AE23 1E17 1D53 0303 76B1 AEC6 6EDD 0C29";
      #     };
      #   }
      # ];
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
      # signing = {
      #   key = "3B65 D56E 51BB 22BC FB8E  E221 8405 F834 149D 0ED8";
      #   signByDefault = true;
      # };
    };
  };
}
