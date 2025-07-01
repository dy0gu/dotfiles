{ config, pkgs, inputs, ... }:

{
  imports = [
    ./base.nix
    ./hyprland.nix
  ];

  # Laptop-specific packages
  home.packages = with pkgs; [
    # GUI applications
    discord
    slack
    spotify

    # Development tools
    vscode

    # System tools
    htop
    neofetch
    acpi
    brightnessctl

    # Power management
    powertop

    # Network tools
    networkmanagerapplet

    # Communication
    thunderbird

    # Lighter alternatives for laptop
    firefox
    mpv
    imv
  ];

  # Configure laptop-specific applications
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        name = "Default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
          "browser.search.defaultenginename" = "DuckDuckGo";
          # Battery optimization settings
          "media.hardware-video-decoding.enabled" = true;
          "layers.acceleration.force-enabled" = true;
        };
      };
    };
  };

  # Laptop-specific services
  services.blueman-applet.enable = true;
}
