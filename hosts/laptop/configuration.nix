{ config, pkgs, inputs, ... }:

{
  networking.hostName = "nixos-laptop";

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
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };

  services.xserver.videoDrivers = [ "modesetting" "fbdev" ];

  # Enable GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Additional font configurations (GNOME handles a lot of them already when enabled)
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];


  # Enable touchpad support (currently disabled to see if GNOME does it automatically)
  # services.libinput.enable = true;

  # Disable some GNOME default applications
  environment.gnome.excludePackages = (with pkgs; [
    epiphany # web browser, we use Firefox
    gedit # text editor, we use Neovim (CLI), Zed (GUI) and the other default gnome editor
    evince # document viewer, we use papers
    gnome-contacts # contact management, not needed
    gnome-disk-utility # disk management, we use gnome-disks
    gnome-music # music player, we use Decibels (GNOME Audio Player)
    gnome-tour # introductory tour, not needed
    gnome-console # terminal, we use Ghostty
    seahorse # keyring management, we use Bitwarden
    gnome-terminal # same as above
    yelp # help application, not needed
    totem # video player, we use Celluloid
    #geary # email client, once Envelope is available start ignoring geary and using it instead
  ]);

  # Alternatives to the disabled defaults above and additional QOL applications
  environment.systemPackages = with pkgs; [
    gnome-decoder # QR code scanner and creator
    papers # Better document viewer
    binary # Binary conversion tools (not in calculator)
    bustle # System D-Bus activity viewer
    celluloid # Video player, supports most formats
    footage # Video trimmer and converter
    switcheroo # Image resizer and format converter
    curtail # Image compression tool
    gaphor # UML, SysML, RAAML and C4 diagram editor
    impression # Bootable drive creator
    share-preview # Local previewer for open graph cards
    fragments # BitTorrent client
  ];

  # GNOME games
  services.gnome.games.enable = false;

  # Standard gaming applications and tools
  programs.steam = {
      enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;

      gamescopeSession.enable = true;

      extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamescope = {
      enable = true;
      capSysNice = true;
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

  # Specializations for NVIDIA
  specialisation.nvidia.configuration = {
    imports = [ ../../modules/firmware/nvidia.nix ];
  };
}
