{ config, pkgs, ... }:

{
  imports = [ ../laptop/configuration.nix ];

  # Enable VirtualBox guest additions
  virtualisation.virtualbox.guest.enable = true;

  # For QEMU/KVM, you might use:
  # virtualisation.qemu.guestAgent.enable = true;
  # For VMware, you might use:
  # virtualisation.vmware.guest.enable = true;
}
