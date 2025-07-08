{ config, pkgs, inputs, ... }:

{
  networking.hostName = "nixos-laptop";

  # Enable GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Add GNOME games
  services.gnome.games.enable = true;

  # Disable some GNOME default applications
  environment.gnome.excludePackages = (with pkgs; [
    epiphany # web browser, using Firefox
    gedit # text editor, using Neovim
    geary # email client, using web interface
    gnome-contacts # contact management, not needed
    gnome-disk-utility # disk management, using gnome-disks
    gnome-music # music player, using audio only
    gnome-tour # introductory tour, not needed
    gnome-console # terminal, using Ghostty
    gnome-keyring # keyring management, using bitwarden
    gnome-terminal # same as above
    yelp # help application, not needed
  ]);

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

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Font configuration
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

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

  # Specializations for NVIDIA
  specialisation.nvidia.configuration = {
    imports = [ ../../modules/firmware/nvidia.nix ];
  };
}
