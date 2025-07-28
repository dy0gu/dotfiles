{ config, pkgs, ... }:

{
  users.users.dy0gu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker"];

    # Should be changed after initial user creation
    initialPassword = "nixos";
  };

  users.users.monitor = {
    # This user is expected to get local auto login enabled as a way to display
    # homelab server stats to a small adjacent screen (and nothing more)
    isNormalUser = false;
    extraGroups = [];

    initialPassword = "nixos";
  };
}
