{ config, pkgs, ... }:

{
  # Disable default system packages
  environment.defaultPackages = with pkgs; [];
  documentation.enable = false;

  # Install packages
  environment.systemPackages = with pkgs; [
    # Main utilities
    curl
    wget
    tree

    # System tools
    btop
    strace

    # Network tools
    nmap
    traceroute
    dig
  ];
}
