{ config, pkgs, ... }:

{
  # Disable default system packages
  environment.defaultPackages = with pkgs; [];
  documentation.enable = false;

  # Add nano as a root backup editor in case a user doesn't install a text editor
  programs.nano.enable = true;

  # Globally enable Git and leave configuration manual to the user
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
    nmap
    strace
    htop
    nvtopPackages.full

    # Network tools
    traceroute
    dig
  ];
}
