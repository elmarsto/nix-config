{ config, lib, pkgs, modulesPath, ... }: let 
  dnsServer = "1.1.1.1";
  domain = "fleshcassette.net";
  nameserver = "1.1.1.1";
  nfsPorts = [ 111 2049 4000 4001 4002 20048 ];
  prefixLength = 24;
  subnetMask = "255.255.255.0";
  thisHost = "fourcade";

  # ports 
  adminPorts = [ sshPort ];  
  torrentPort = 51413;
  avahiUdpPorts = [ 5353 53791 ];
  contentPorts =  webPorts;
  dbPorts = [ postgresPort ]; # TODO: add redis? mongo!? um, neo4j? lol completeness
  dhcpUdpPort = 67;
  dnsPort = 53;
  mailPorts = [ 25 143 465 587 993 ];
  postgresPort = 5432;
  resolverTcpPorts = [ dnsPort ];
  resolverUdpPorts = resolverTcpPorts ++ [ dhcpUdpPort ] ++ avahiUdpPorts;
  sshPort = 22;
  syncthingTcpPorts = [ 22000 8384 ];
  syncthingUdpPorts = [ 22000 21027 ];
  vpnPorts = [ 3478 41641 51820 ]; # tailscale, wireguard
  webPorts = [ 80 443 ];
  # we do programs.mosh.enable in commmon and that also opens udp 60000-61000 :/ 

  wanPorts = {
    allowedTCPPorts = [ torrentPort ];
    allowedUDPPorts = vpnPorts ++ [ torrentPort ]; 
  };

  lanPorts = {
    allowedTCPPorts = wanPorts.allowedTCPPorts ++ resolverTcpPorts ++ syncthingTcpPorts ++ adminPorts ++ contentPorts;
    allowedUDPPorts = wanPorts.allowedUDPPorts ++ resolverUdpPorts ++ syncthingUdpPorts ++ nfsPorts;
  };

  trustedNetworkPorts = {
    allowedTCPPorts = lanPorts.allowedTCPPorts ++ nfsPorts ++ mailPorts ++ dbPorts;
    allowedUDPPorts = lanPorts.allowedUDPPorts ++ nfsPorts;
  };

in {
    boot.kernel.sysctl = {
       "net.ipv4.conf.all.forwarding" = true;
       #"net.ipv6.conf.all.forwarding" = true;

       # source: https://github.com/mdlayher/homelab/blob/master/nixos/routnerr-2/configuration.nix#L52
       #"net.ipv6.conf.all.accept_ra" = 0;
       #"net.ipv6.conf.all.autoconf" = 0;
       #"net.ipv6.conf.all.use_tempaddr" = 0;

#       "net.ipv6.conf.${name}.accept_ra" = 2;
#       "net.ipv6.conf.${name}.autoconf" = 1;
    };
    networking = {
      hostId = "1183aa1f"; # first 8 of /etc/machine-id; required for zfs
      firewall = {
        trustedInterfaces = [ "virbr0" "wg0" "tailscale0" ];
        checkReversePath = "loose";
      };
      networkmanager.enable = false; # just being explicit for my own sanity
      nat = {
        enable = true;
        internalInterfaces = [ "virbr0" "wg0" "tailscale0" ];
        internalIPs = [ "10.1.47.0/24" "192.168.122.0/24" ];
      };
      hostName = thisHost; 
      enableIPv6 = false;
      nameservers = [ nameserver ];
      firewall = {
        enable = true;
        allowPing = true;
        interfaces = {
          virbr0 = lanPorts;
          wg0 = trustedNetworkPorts;
          tailscale0 = lanPorts;
        };
      };
    };
    services = {
      avahi = {
        enable = true;
        openFirewall = true;
        reflector = true;
        nssmdns = true;
        publish = {
          enable = true;
          addresses = true;
          workstation = true;
          userServices = true;
        };
      };
      fail2ban = {
        enable = true;
        maxretry = 5;
      };
      samba = {
        enable = true;
        securityType = "user";
        extraConfig = ''
          workgroup = WORKGROUP
          server string = fourcade
          netbios name = fourcade
          security = user 
          #use sendfile = yes
          #max protocol = smb2
          # note: localhost is the ipv6 localhost ::1
          hosts allow = 192.168.122. 127.0.0.1 localhost
          hosts deny = 0.0.0.0/0
          guest account = nobody
          map to guest = bad user
        '';
        shares = {
          # FIXME: should be shares for vms
        };
      };
      openssh = {
        enable = true;
        settings = {
          X11Forwarding = true;
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
        extraConfig = ''
          AllowAgentForwarding yes
        '';
      };
      tailscale.enable = true;
    }; 
}
