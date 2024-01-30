{ config, pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true; #
    package = pkgs.starship;
    settings = {
      # this is ugly but ''..'' didn't work with \, \\, or \\\\
      format = "[](#9A348E)$battery$shell[](bg:#A0627D
      fg:#9A348E)$directory[](fg:#A0627D
      bg:#FCA17D)$git_state$git_branch$git_commit$git_status[](fg:#FCA17D
      bg:#86BBD8)$deno$lua$nodejs$python$rust[](fg:#86BBD8
      bg:#06969A)$shlvl$nix_shell$docker_context[](fg:#06969A
      bg:#33658A)$jobs$cmd_duration[](fg:#33658A) ";
      # username = {
      #   show_always = true;
      #   style_user = "bg:#9A348E fg:#000000";
      #   style_root = "bg:#9A348E fg:#FF0000";
      #   format = "[$user]($style)";
      # };
      # hostname = {
      #   disabled = false;
      #   ssh_only = true;
      #   ssh_symbol = "🌐";
      #   style = "bg:#9A348E fg:#000000";
      #   format = "[$ssh_symbol$hostname]($style)";
      # };

      shell = {
        disabled = false;
        bash_indicator = ""; # a bash, as a kind of party, has balloons
        powershell_indicator = "🔌";
        elvish_indicator = "🧝";
        xonsh_indicator = "🐚";
        nu_indicator = "✨";
        style = "bg:#9A348E";
        format = "[$indicator]($style)";
      };

      directory = {
        style = "bg:#A0627D";
        format = "[$path]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        read_only = " ";
        substitutions = {
          "Documents" = " ";
          "Downloads" = " ";
          "Music" = " ";
          "Audio" = " ";
          "Pictures" = " ";
          "Video" = " ";
          "code" = "{}";
        };
      };

      # aws.symbol = "  ";
      # azure.symbol = "  ";
      # buf.symbol = " ";
      #

      git_branch = {
        symbol = " ";
        style = "bg:#FCA17D fg:#000000";
        format = "[[$symbol$branch](bg:#FCA17D fg:#000000)]($style)";
        ignore_branches = ["main" "master"];
        only_attached = true;
      };

      git_status = {
        style = "bg:#FCA17D fg:#000000";
        format = "[[($all_status$ahead_behind)](bg:#FCA17D fg:#000000)]($style)";
      };
      
      git_commit = {
        style = "bg:#FCA17D fg:#000000";
        only_detached = true;
        tag_disabled = false;
        format = "[[($hash$tag)](bg:#FCA17D fg:#000000)]($style)";
      };

      git_state = {
        style = "bg:#FCA17D fg:#000000";
        format = "[[($state)](bg:#FCA17D fg:#000000)]($style)";
        merge = "";
        rebase = "";
        revert = "";
        cherry_pick = "";
        bisect = "≬";
      };

      deno = {
        symbol = " ";
        style = "bg:#86BBD8 fg:#000000";
        format = "[[$symbol](bg:#86BBD8 fg:#000000)]($style)";
      };

      lua = {
        symbol = " ";
        style = "bg:#86BBD8 fg:#000000";
        format = "[[$symbol](bg:#86BBD8 fg:#000000)]($style)";
      };

      nix_shell = {
        symbol = " ";
        style = "bg:#06969A fg:#000000";
        format = "[[$symbol$name](bg:#06969A fg:#000000)]($style)";
        heuristic = true;
      };

      shlvl = {
        style = "bg:#06969A fg:#000000";
        symbol = "∫";
        repeat = true;
        repeat_offset = 0;
        threshold = 0;
        format = "[[$symbol$name](bg:#06969A fg:#000000)]($style)";
        disabled = false;
      };

      nodejs = {
        symbol = " ";
        style = "bg:#86BBD8 fg:#000000";
        format = "[[$symbol](bg:#86BBD8 fg:#000000)]($style)";
      };

      python = {
        symbol = " ";
        style = "bg:#86BBD8 fg:#000000";
        format = "[[$symbol](bg:#86BBD8 fg:#000000)]($style)";
      };

      rust = {
        symbol = " ";
        style = "bg:#86BBD8 fg:#000000";
        format = "[[$symbol](bg:#86BBD8: fg:#000000)]($style)";
      };

      docker_context = {
        symbol = " ";
        style = "bg:#06969A";
        format = "[[$symbol$context](bg:#06969A)]($style) $path";
      };

      # package = {
      #   symbol = " ";
      #   style = "bg:#06969A";
      #   format = "[[ $symbol ($version) ](bg:#06969A)]($style)";
      # };

      cmd_duration = {
        style = "bg:#33658A";
        min_time = 500;
        format = "[$duration]($style)";
        disabled = true;
      };

      jobs = {
        style = "bg:#33658A";
        symbol = " ";
        format = "[$symbol]($style)";
        disabled = false;
      };

    };
  };
}
