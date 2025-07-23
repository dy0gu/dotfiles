{ config, pkgs, inputs, ... }:

{
  networking.hostName = "nixos-lt";

  # Enable networking
  networking.networkmanager.enable = true;

  # Disable internal NetworkManager DNS resolution
  networking.networkmanager.dns = "none";

  # These options are unnecessary when managing DNS ourselves
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  # Configure DNS servers manually (Cloudflare and Google DNS)
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

  # GPU handling
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };

  # # Enable Nvidia support
  # hardware.nvidia = {
  #   # Old GPUs need proprietary drivers so this can only be true for newer GPUs
  #   open = false;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };
  # # Enable the NVIDIA container toolkit for virtualization services (e.g. Docker)
  # # hardware.nvidia-container-toolkit.enable = true;

  # # Manually set GPU driver preference (if not found, will automatically try the next one in the list)
  # services.xserver.videoDrivers = [ "nvidia" "modesetting" "fbdev" ];
  services.xserver.videoDrivers = [ "modesetting" "fbdev" ];

  # Enable touchpad support (currently disabled to see if GNOME does it automatically)
  # services.libinput.enable = true;

  # Enable GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Disable some GNOME default applications
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = (with pkgs; [
    epiphany # web browser, we use Firefox
    gedit # text editor, we use Neovim (CLI), Zed (GUI) and the other default gnome editor
    evince # document viewer, we use papers
    gnome-disk-utility # disk management, we use gnome-disks
    gnome-music # music player, we use Decibels (GNOME Audio Player)
    gnome-tour # introductory tour, not needed
    gnome-console # terminal, we use Ghostty
    gnome-terminal # same as above
    totem # video player, we use Celluloid
    seahorse # keyring frontend GUI, not needed
    yelp # help application, not needed
    geary # email client, we use web, waiting for Envelope (https://gitlab.gnome.org/felinira/envelope) to replace it
  ]);

  # Alternatives to the disabled defaults above and additional QOL applications
  environment.systemPackages = with pkgs; [
    # clamtk # Anti-virus GUI [LOOKS OUTDATED], using ClamAV as the backend !!BROKEN, NEEDS REPLACING!!!!
    libreoffice-fresh # Office suite, [LOOKS OUTDATED], waiting on gtk 4 migration update
    gimp3-with-plugins # Image editor, [LOOKS OUTDATED], waiting on gtk 4 migration update
    shotcut # Video editor, [LOOKS OUTDATED], waiting on gtk 4 migration update
    gnome-decoder # QR code scanner and creator
    papers # Better document viewer
    bustle # System D-Bus activity viewer
    bitwarden # Password manager
    celluloid # Video player, supports most formats
    gaphor # UML, SysML, RAAML and C4 diagram editor
    impression # Bootable drive creator
    share-preview # Local previewer for open graph cards
    fragments # BitTorrent client
  ];
  programs.firefox = {
    enable = true;
  };
  programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
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

  # Additional font configurations (GNOME handles a lot of them already when enabled)
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
