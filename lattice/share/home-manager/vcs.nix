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
    # sessionVariables = {
    #   GIT_PAGER = "delta";
    # };
  };
  programs = {
    bash.initExtra = ''
         export JUST_UNSAFE=1
         alias g='git';
      #   GIT_PAGER = "delta";
    '';
    git-cliff.enable = true;
    git-worktree-switcher.enable = true;
    gitui.enable = true;
    patdiff = {
      enable = true;
      enableGitIntegration = true;
    };
    git = {
      settings = {
        alias = {
          c = "commit";
          co = "checkout";
          m = "merge";
          p = "pull";
          P = "push";
          r = "rebase";
          s = "switch";
        };
        user.name = "Elizabeth Marston";
        user.email = "315987+elmarsto@users.noreply.github.com";
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
      enable = true;
      package = pkgs.gitFull;
      lfs.enable = true;
      ignores = [
        "CLAUDE.md"
        "/.claude/"
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
    };
  };
}
