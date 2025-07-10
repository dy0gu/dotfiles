{ config, pkgs, lib, ... }:

{
  # Extend an existing configuration for testing purposes
  imports = [ ../laptop/configuration.nix ];

  # Overwrite the repurposed config hostname
  networking.hostName = lib.mkForce "nixos-vm";
  # No need to enable virtualization settings for VM, hardware-configuration.nix should automatically detect and add them
}
