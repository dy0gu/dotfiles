{ config, pkgs, ... }:

{
  users.users.dy0gu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "audio" "wheel" "docker" ];

    # Should be changed after initial user creation
    initialPassword = "nixos";
  };
}
