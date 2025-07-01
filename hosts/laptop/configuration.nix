{ config, pkgs, inputs, ... }:

{
  networking.hostName = "nixos-laptop";

  # Enable networking with WiFi support
  networking.wireless.enable = false; # Disable wpa_supplicant, using NetworkManager
  networking.networkmanager.enable = true;

  # Enable X11 and Hyprland
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
  };

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
  services.blueman.enable = true;

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
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.fira-code
  ];

  # Laptop-specific settings
  # Enable lid switch handling
  services.logind.lidSwitch = "suspend";
}
