{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos-server";

  # Disable desktop services
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  # Enable networking
  networking.networkmanager.enable = false;
  systemd.network.enable = true;
  systemd.network.networks."10-ethernet" = {
    matchConfig.Name = "en*";
    networkConfig = {
      DHCP = "yes";
      IPForward = true;
    };
  };

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
