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

  # Enable sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Power management
  services.tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;

          # Helps save long term battery health
          START_CHARGE_THRESH_BAT1 = 20;
          STOP_CHARGE_THRESH_BAT1 = 80;

        };
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # Laptop-specific packages
  environment.systemPackages = with pkgs; [
    firefox
    kitty
    pavucontrol
    bluez
    bluez-tools
    networkmanagerapplet
    acpi
    powertop
  ];

  # Set Kitty as default terminal in GNOME
  environment.variables = {
    TERMINAL = "kitty";
  };

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

  # Laptop-specific settings
  # Enable lid switch handling
  services.logind.lidSwitch = "suspend";

  # Specializations for NVIDIA
  specialisation.nvidia.configuration = {
    imports = [ ../../modules/firmware/nvidia.nix ];
  };
}
