{ config, pkgs, ... }:

{
  # Disable default system packages
  environment.defaultPackages = with pkgs; [];
  documentation.enable = false;
  programs.nano.enable = false;

  # Install packages
  environment.systemPackages = with pkgs; [
    # Main utilities
    nvim
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
