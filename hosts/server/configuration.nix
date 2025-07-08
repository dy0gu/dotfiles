{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos-server";

  # Disable desktop services
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;

  # Disable internal NetworkManager DNS resolution
  networking.networkmanager.dns = "none";

  # These options are unnecessary when managing DNS ourselves
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  # Configure DNS servers manually (this example uses Cloudflare and Google DNS)
  # IPv6 DNS servers can be used here as well.
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 2222 ];
  };

  # SSH configuration
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      AllowUsers = [ "dbsim" ];
    };
    openFirewall = true;
  };

  # Fail2ban for SSH protection
  services.fail2ban = {
    enable = true;
    jails = {
      ssh = ''
        enabled = true
        port = 2222
      '';
    };
  };

  # Docker configuration
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      storage-driver = "overlay2";
      log-driver = "json-file";
      log-opts = {
        "max-size" = "10m";
        "max-file" = "3";
      };
    };
  };
}
