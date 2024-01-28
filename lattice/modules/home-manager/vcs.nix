{ config, lib, pkgs, ... }:
let
  guiPkgs = with pkgs; [
    meld
    #sublime-merge
  ];
  termPkgs = with pkgs; [
    git-interactive-rebase-tool
    git-lfs
    gitui
    hub
  ];
in
{
  config = {
    home = {
      packages = if config.lattice.gui.enable then termPkgs ++ guiPkgs else termPkgs;
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
        userName = config.lattice.vcs.name;
        userEmail = config.lattice.vcs.email;
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
  };
  options = {
    lattice.vcs = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Human-readable name for VCS";
      };
      email = lib.mkOption {
        type = lib.types.str;
        description = "Email address for VCS";
      };
    };
  };
}
