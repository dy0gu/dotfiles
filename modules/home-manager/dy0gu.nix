{ config, pkgs, inputs, ... }:
{
  programs.home-manager.enable = true;

  home.username = "dy0gu";
  home.homeDirectory = "/home/dy0gu";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # Development tools
    nodejs
    python3
    rustc
    cargo

    # Media
    mpv
    imv

    # Archives
    p7zip
    unrar

    # GUI applications
    discord
    slack
    spotify

    # Development tools
    vscode

    # System tools
    htop
    neofetch
    acpi
    brightnessctl

    # Power management
    powertop

    # Network tools
    networkmanagerapplet

    # Communication
    thunderbird

    # Lighter alternatives for laptop
    firefox
    mpv
    imv

    # Terminal emulator
    alacritty

    # Gnome extensions and themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.show-desktop-button
    gnomeExtensions.user-themes
    whitesur-gtk-theme
    whitesur-icon-theme
  ];

  # Gnome settings using dconf
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-uri = "file:///home/dy0gu/dotfiles/wallpapers/background.png";
        picture-uri-dark = "file:///home/dy0gu/dotfiles/wallpapers/background-dark.png";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        # Disable mouse acceleration
        acceleration-profile = "flat";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "WhiteSur-Dark-solid";
        icon-theme = "WhiteSur-Dark";
        cursor-theme = "WhiteSur-cursors";
      };

      "org/gnome/shell" = {
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "show-desktop-button@amivaleo"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Terminal.desktop"
          "org.gnome.TextEditor.desktop"
          "org.gnome.Extensions.desktop"
          "org.gnome.Settings.desktop"
          "org.gnome.tweaks.desktop"
        ];
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "WhiteSur-Dark-solid";
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        background-opacity = 0.8;
        click-action = "previews";
        custom-theme-shrink = true;
        dash-max-icon-size = 32;
        dock-fixed = true;
        dock-position = "LEFT";
        extend-height = true;
        height-fraction = 0.9;
        intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      };
    };
  };

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

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        name = "Default";
        isDefault = true;
        settings = {
          "browser.search.defaultenginename" = "DuckDuckGo";
          "media.hardware-video-decoding.enabled" = true;
          "layers.acceleration.force-enabled" = true;
        };
      };
    };
  };

  # Terminal configuration
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.5;
      confirm_os_window_close = false;
    };
  };
}
