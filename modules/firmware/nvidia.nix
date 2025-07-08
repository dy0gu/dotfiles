{ config, lib, pkgs, ... }:

{
  hardware.nvidia = {
    modesetting.enable = true;

    # Nvidia power management, experimental, and can cause sleep/suspend to fail
    powerManagement.enable = false;

    # Turns off GPU when not in use, experimental and only works on modern Nvidia GPUs (Turing or newer)
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module, only recommended for newer GPUs
    open = false;

    # Enable the Nvidia settings menu, accessible via `nvidia-settings`
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia-container-toolkit.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # Ensure nvidia-drm.modeset=1 is set for Wayland
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # Required for nvidia on wayland
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
