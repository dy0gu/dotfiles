{ config, pkgs, inputs, ... }:

{
  # Hostname
  networking.hostName = "nixos-laptop";

  # Enable networking with WiFi support
  networking.networkmanager.enable = true;
  networking.wireless.enable = false; # Disable wpa_supplicant, using NetworkManager

  # Enable X11 and Hyprland
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
  };

  # Enable sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  # Power management for laptops
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Enable touchpad support
  services.xserver.libinput.enable = true;

  # Laptop-specific packages
  environment.systemPackages = with pkgs; [
    firefox
    alacritty
    waybar
    wofi
    mako
    grim
    slurp
    wl-clipboard
    brightnessctl
    pavucontrol
    bluez
    bluez-tools
    networkmanagerapplet
    acpi
    powertop
  ];

  # Enable some desktop services
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  # Font configuration
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.fira-code
  ];

  # Laptop-specific settings
  # Enable lid switch handling
  services.logind.lidSwitch = "suspend";
}
