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
      enable = true;
      package = pkgs.gitFull;
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

      extraConfig = {
        pull.ff = "only";
        push.autoSetupRemote = true;
        global.sequence.editor = "${pkgs.git-interactive-rebase-tool}/bin/interactive-rebase-tool";
        credential.helper = "libsecret";
        init.defaultBranch = "main";
        difftool = {
          prompt = true;
          nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        };
        diff.tool = "nvimdiff";
        merge.tool = "nvimdiff";
      };
    };
  };
}
