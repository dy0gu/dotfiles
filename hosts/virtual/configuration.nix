{ config, pkgs, lib, ... }:

{
  # Extend an existing configuration for testing purposes
  imports = [ ../laptop/configuration.nix ];

  # Overwrite the repurposed config hostname
  networking.hostName = lib.mkForce "nixos-virtual-machine";

  # Enable VirtualBox guest additions
  virtualisation.virtualbox.guest.enable = true;

  # For QEMU/KVM, you might use:
  # virtualisation.qemu.guestAgent.enable = true;
  # For VMware, you might use:
  # virtualisation.vmware.guest.enable = true;
}
