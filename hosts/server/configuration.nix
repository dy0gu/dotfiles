{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos-server";

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

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 2222 ];
  };

  # Disable desktop services
  services.xserver.enable = false;
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  # Server-specific packages
  environment.systemPackages = with pkgs; [
    tmux
    screen
    rsync
    fail2ban
  ];

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
}
