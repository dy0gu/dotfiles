{ config, lib, pkgs, ... }:

{
  hardware.nvidia = {
    # Use only open source Nvidia kernel modules (old GPUs need proprietary drivers)
    open = false;

    # Branch to use for the NVidia driver
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Load nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable the NVIDIA container toolkit for virtualization services (e.g. Docker)
  hardware.nvidia-container-toolkit.enable = true;
}
