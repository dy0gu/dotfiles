{ config, pkgs, ... }:

{
  # Disable default system packages
  environment.defaultPackages = with pkgs; [];
  documentation.enable = false;

  # Leave nano as backup in case a user doesn't install a text editor
  programs.nano.enable = true;

  # Install packages
  environment.systemPackages = with pkgs; [
    # Main utilities
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
