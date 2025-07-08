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

    # GUI applications
    discord
    slack
    spotify
    code-cursor-fhs

    # System tools
    btop
    fastfetch
  ];

  programs.lazydocker.enable = true;

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.thunderbird = {
    enable = true;
    profiles = {
      dy0gu = {
        isDefault = true;
      };
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


  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Fira Code";
      font_size = 14.0;
      cursor_shape = "Beam";
      background_opacity = 0.8;
      allow_remote_control = true;
      shell = "zsh --login";
    };
  };

  # Gnome settings using dconf
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-uri = "file:///home/dy0gu/dotfiles/wallpapers/background.png";
        picture-uri-dark = "file:///home/dy0gu/dotfiles/wallpapers/background.png";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        # Disable mouse acceleration
        acceleration-profile = "flat";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/default-applications/terminal" = {
        exec = "kitty";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.TextEditor.desktop"
          "org.gnome.Settings.desktop"
        ];
      };
    };
  };
}
