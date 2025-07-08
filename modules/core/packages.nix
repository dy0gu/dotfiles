{ config, pkgs, ... }:

{
  # Install packages
  environment.systemPackages = with pkgs; [
    # Main utilities
    curl
    wget
    tree
    unzip
    zip

    # System tools
    btop

    # Network tools
    nmap
    traceroute
    dig
  ];
}
