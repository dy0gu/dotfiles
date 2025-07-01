{ config, pkgs, ... }:

{
  home.username = "dy0gu";
  home.homeDirectory = "/home/dy0gu";

  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      la = "ls -la";
      l = "ls -l";
      rebuild = "sudo nixos-rebuild switch --flake .";
      update = "nix flake update";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
      theme = "robbyrussell";
    };
  };

  home.packages = with pkgs; [
    # Development tools
    nodejs
    python3
    rustc
    cargo

    # Utilities
    fd
    ripgrep
    bat
    exa
    delta

    # Media
    mpv
    imv

    # Archives
    p7zip
    unrar
  ];

  programs.home-manager.enable = true;
}
