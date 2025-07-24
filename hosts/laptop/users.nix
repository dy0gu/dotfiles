{ config, pkgs, ... }:

{
  users.users.dy0gu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "audio" "wheel" "docker" "podman" ];

    # Should be changed after first user creation
    initialPassword = "nixos";
  };
}
