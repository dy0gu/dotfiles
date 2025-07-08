{ config, pkgs, ... }:

{
  # Install packages
  environment.systemPackages = with pkgs; [
    # Main utilities
    curl
    wget
    tree

    # System tools
    btop

    # Network tools
    nmap
    traceroute
    dig
  ];

  # Disable unused defaults
  programs.nano.enable = false;
}
