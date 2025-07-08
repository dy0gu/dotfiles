{ config, pkgs, inputs, ... }:

{
  networking.hostName = "nixos-laptop";

  # Enable GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable networking with WiFi support
  networking.wireless.enable = false; # Disable wpa_supplicant, using NetworkManager
  networking.networkmanager.enable = true;

  # Disable NetworkManager's internal DNS resolution
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

  networking.networkmanager.wifi.powersave = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Laptop-specific packages
  programs.kitty.enable = true;

  # Set Kitty as default terminal in GNOME
  environment.variables = {
    TERMINAL = "kitty";
  };

  programs.zsh.enable = true;

  # Set Zsh as default shell for all users
  users.defaultUserShell = pkgs.zsh;

  # Font configuration
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.fira-code
  ];

  # Specializations for NVIDIA
  specialisation.nvidia.configuration = {
    imports = [ ../../modules/firmware/nvidia.nix ];
  };
}
