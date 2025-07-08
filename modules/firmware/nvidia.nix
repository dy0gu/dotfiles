{ config, lib, pkgs, ... }:

{
  hardware.nvidia = {
    # Use only open source Nvidia kernel modules (old GPUs need proprietary drivers)
    open = false;

    # Branch to use for the NVidia driver
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Load nvidia drivers in adition to the others previously configured
  services.xserver.videoDrivers = lib.mkIf (config.services.xserver.enable) (lib.mkMerge [
    (config.services.xserver.videoDrivers or [])
    [ "nvidia" ]
  ]);


  # Enable the NVIDIA container toolkit for virtualization services (e.g. Docker)
  hardware.nvidia-container-toolkit.enable = true;
}
