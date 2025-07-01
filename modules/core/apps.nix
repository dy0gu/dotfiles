{ config, pkgs, ... }:

{
  # Enable programs
  programs.zsh.enable = true;

  # Install packages
  environment.systemPackages = with pkgs; [
    # Main utilities
    vim
    neovim
    git
    curl
    wget
    htop
    tree
    unzip
    zip

    # System tools
    pciutils
    usbutils
    lshw

    # Network tools
    nmap
    traceroute
    dig
  ];
}
