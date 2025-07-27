{ config, pkgs, ... }:

{
  # Enable Nvidia support
  hardware.nvidia = {
    # Old GPUs need proprietary drivers so this can only be true for newer GPUs
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Manually set GPU driver preference (if not found, will automatically try the next one in the list)
  services.xserver.videoDrivers = [ "nvidia" "modesetting" "fbdev" ];

  # Enable the NVIDIA container toolkit for virtualization services (e.g. Docker or Podman)
  hardware.nvidia-container-toolkit.enable = true;
}
