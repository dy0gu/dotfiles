{ config, pkgs, ... }:

{
  # Disable default system packages
  environment.defaultPackages = with pkgs; [];
  documentation.enable = false;

  # Leave nano as backup in case a user doesn't install a text editor
  programs.nano.enable = true;

  # Globally enable Git and leave configuration out of home-manager
  programs.git.enable = true;

  # Install packages
  environment.systemPackages = with pkgs; [
    # Main utilities
    git
    curl
    wget
    tree
    jq
    unzip
    zip

    # System tools
    htop
    strace

    # Network tools
    nmap
    traceroute
    dig
  ];
}
