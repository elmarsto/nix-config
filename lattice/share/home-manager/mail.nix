{ config, pkgs, lib, ... }:
let
  me = config.home.username;
  host = "100.69.208.95";
  fleshyPassword = "/etc/secrets/fleshy-email-password.sh";
  newsletterPassword = "/etc/secrets/newsletter-email-password.sh";
  protonPassword = "/etc/secrets/proton-email-password.sh";
in
{
  home.packages = with pkgs; [
    protonmail-bridge
    hydroxide
    thunderbird
  ];
  accounts.email.accounts = {
    root = {
      address = "root@fleshcassette.net";
      realName = "Root";
      imap = {
        host = host;
        port = 993;
        tls.enable = true;
      };
      primary = false;
      passwordCommand = fleshyPassword;
      notmuch.enable = true;
      smtp = {
        host = host;
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      userName = "root@fleshcassette.net";
      himalaya = {
        enable = true;
        backend = "imap";
        sender = "smtp";
        settings = {
          imap-insecure = true;
          smtp-insecure = true;
          smtp-starttls = true;
        };
      };
    };
    saccades = {
      address = "lattice@saccades.ca";
      realName = "Lattice";
      aliases = [
        "lattice@fleshcassette.net"
      ];
      imap = {
        host = host;
        port = 993;
        tls.enable = true;
      };
      primary = false;
      passwordCommand = fleshyPassword;
      notmuch.enable = true;
      smtp = {
        host = host;
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      userName = "lattice@saccades.ca";
      himalaya = {
        enable = true;
        sender = "smtp";
        backend = "imap";
        settings = {
          imap-insecure = true;
          smtp-insecure = true;
          smtp-starttls = true;
        };
      };
    };
    newsletter = {
      address = "newsletter@lizmars.net";
      realName = "Liz Mars Newsletter";
      imap = {
        host = host;
        port = 993;
        tls.enable = true;
      };
      primary = false;
      passwordCommand = newsletterPassword;
      notmuch.enable = true;
      smtp = {
        host = host;
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      userName = "newsletter@lizmars.net";
      himalaya = {
        enable = true;
        backend = "imap";
        sender = "smtp";
        settings = {
          imap-insecure = true;
          smtp-insecure = true;
          smtp-starttls = true;
        };
      };
    };
    lizmars = {
      address = "her@lizmars.net";
      realName = "Liz";
      aliases = [
        "her@elizabethmarston.net"
      ];
      imap = {
        host = host;
        port = 993;
        tls.enable = true;
      };
      primary = true;
      passwordCommand = fleshyPassword;
      notmuch.enable = true;
      smtp = {
        host = host;
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      userName = "her@lizmars.net";
      himalaya = {
        enable = true;
        backend = "imap";
        sender = "smtp";
        settings = {
          imap-insecure = true;
          smtp-insecure = true;
          smtp-starttls = true;
        };
      };
    };
    pm = {
      address = "1attice@proton.me";
      realName = "Liz";
      aliases = [ "1attice@protonmail.com" "liz.mars@pm.me" ];
      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      primary = false;
      passwordCommand = protonPassword;
      notmuch.enable = true;
      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      userName = "1attice@proton.me";
      himalaya = {
        enable = true;
        backend = "imap";
        sender = "smtp";
        settings = {
          imap-insecure = true;
          smtp-insecure = true;
          smtp-starttls = true;
        };
      };
    };
  };
  programs = {
    himalaya.enable = true;
    # thunderbird.enable = true; # TODO: nixify
  };
}

