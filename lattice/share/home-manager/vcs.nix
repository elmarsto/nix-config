{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    git-worktree-switcher.enable = true;
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
        fetch = {
          fsckobjects = true;
          prune = true;
          prunetags = true;
        };
        init.defaultbranch = "main";
        log.date = "iso";
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
