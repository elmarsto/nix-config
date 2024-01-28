{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    mosh
    sshfs
  ];
  programs = {
    bash.initExtra = ''
      # home-manager keeps donking ssh-agent up so here is oldschool
      # adapted from https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
      SSH_ENV="${config.home.homeDirectory}/.ssh/agent-environment"

      function start_agent {
          echo "Initialising new SSH agent..."
          ${pkgs.openssh}/bin/ssh-agent | ${pkgs.gnused}/bin/sed 's/^echo/#echo/' > "''${SSH_ENV}"
          echo succeeded
          ${pkgs.coreutils}/bin/chmod 600 "''${SSH_ENV}"
          . "''${SSH_ENV}" > /dev/null
          ${pkgs.openssh}/bin/ssh-add;
      }

      if [ -f "''${SSH_ENV}" ]; then
          . "''${SSH_ENV}" > /dev/null
          ${pkgs.procps}/bin/ps -ef | ${pkgs.gnugrep}/bin/grep "''${SSH_AGENT_PID}" | ${pkgs.gnugrep}/bin/grep 'ssh-agent$' > /dev/null || {
              start_agent;
          }
      else
          start_agent;
      fi
    '';
    ssh = {
      enable = true;
      controlMaster = "auto";
      controlPath = "/tmp/${config.home.username}-%r@%h:%p";
      controlPersist = "10m";
      compression = true;
      matchBlocks = {
        root = {
          # root@localhost
          forwardAgent = true;
          hostname = "127.0.0.1";
          user = "root";
          identityFile = "~/.ssh/id_ed25519_sk";
        };
        fleshy = {
          # fleshcassette.net
          forwardAgent = true;
          hostname = "sec.fleshcassette.net";
          user = "lattice";
          identityFile = "~/.ssh/id_ed25519_sk";
          localForwards = [
            {
              # syncthing admin
              bind.port = 8385;
              host.port = 8384;
              host.address = "127.0.0.1";
            }
          ];
        };
        hackflesh = {
          forwardAgent = true;
          hostname = "sec.fleshcassette.net";
          user = "root";
          identityFile = "~/.ssh/id_ed25519_sk";
          localForwards = [
            {
              # workspace-portal
              bind.port = 8385;
              host.port = 8384;
              host.address = "127.0.0.1";
            }
          ];
        };
        fourcade = {
          forwardAgent = true;
          hostname = "100.67.196.97";
          user = "lattice";
          identityFile = "~/.ssh/id_ed25519_sk";
        };
        bowsprit = {
          forwardAgent = true;
          hostname = "100.100.65.126";
          user = "lattice";
          identityFile = "~/.ssh/id_ed25519_sk";
        };
        sopwith = {
          forwardAgent = true;
          hostname = "100.102.187.120";
          user = "lattice";
          identityFile = "~/.ssh/id_ed25519_sk";
        };
        s13 = {
          # phone
          forwardAgent = true;
          hostname = "s13.obsda.ms";
          port = 31415;
          user = "lattice";
          identityFile = "~/.ssh/id_ed25519_sk";
        };
      };
      extraConfig =
        ''
          AddKeysToAgent yes
          Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
          KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256
          MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128-etm@openssh.com
          HostKeyAlgorithms ssh-ed25519,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,rsa-sha2-256,rsa-sha2-256-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-512-cert-v01@openssh.com
        '';
    };
  };
}

