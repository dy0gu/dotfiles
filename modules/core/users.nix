{ config, pkgs, ... }:

{
  users.users.dy0gu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
    shell = pkgs.zsh;

    # Should be changed after first user creation
    initialPassword = "nixos";
  };
}
