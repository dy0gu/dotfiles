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
    go
    lua
    ruby
    perl

    # GUI applications
    gnome-decoder # QR code scanner and creator
    papers # Better document viewer
    binary # Binary conversion tools (not in calculator)
    bustle # System D-Bus activity viewer
    curtail # Image compression tool
    gaphor # UML, SysML, RAAML and C4 diagram editor
    libreoffice # Office suite
    impression # Bootable drive creator
    share-preview # Local previewer for open graph cards
    fragments # BitTorrent client
    davinci-resolve # Video editor, troubleshooting: https://wiki.nixos.org/wiki/DaVinci_Resolve
    gimp3-with-plugins # Image editor
    discord

    # System utilities
    fastfetch

    # Gnome extensions
    gnomeExtensions.clipboard-history
    gnomeExtensions.color-picker
    gnomeExtensions.caffeine
    gnomeExtensions.vitals
  ];

  # CLI docker management tool
  programs.lazydocker.enable = true;

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        name = "Default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://duckduckgo.com";
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";

          "signon.rememberSignons" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.compactmode.show" = true;
          "browser.cache.disk.enable" = false;

          "media.hardware-video-decoding.enabled" = true;
          "layers.acceleration.force-enabled" = true;
          "widget.disable-workspace-management" = true;
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
      rebuild = "sudo nixos-rebuild switch --flake";
      update = "nix flake update";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
      theme = "af-magic";
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      command = "zsh --login";
      theme = "Afterglow";
      title = "Terminal";
      font-family = "FiraCode Nerd Font";
      window-subtitle = false;
      window-inherit-working-directory = true;
      clipboard-trim-trailing-spaces = true;
      keybind = [
        "ctrl+h=goto_split:left"
        "ctrl+l=goto_split:right"
      ];
    };
    themes = {};
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "material-icon-theme"
      "nix"
    ]
  }

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
      gruvbox-material
      mini-nvim
    ];
  };

  # Gnome settings using dconf
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-uri = "file:///home/dy0gu/.dotfiles/wallpapers/background.png";
        picture-uri-dark = "file:///home/dy0gu/.dotfiles/wallpapers/background.png";
      };

      "org/gnome/login-screen" = {
        banner-message-enable = false;
        logo = "";
      };



      "org/gnome/desktop/peripherals/mouse" = {
        # Disable mouse acceleration
        acceleration-profile = "flat";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
      };

      "org/gnome/desktop/a11y" = {
        always-show-universal-access-status = false;
      };

      "org/gnome/Console" = {
        shell = "/run/current-system/sw/bin/zsh --login";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/desktop/default-applications" = {
        terminal = "exec ghostty";
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "clipboard-indicator@tudmotu.com"
          "color-picker@tudmotu.com"
          "caffeine@tudmotu.com"
          "vitals@tudmotu.com"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.TextEditor.desktop"
          "org.gnome.Settings.desktop"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
        close = ["<Alt>F4" "<Super>q"];
        switch-to-workspace-left = ["<Super>Left"];
        switch-to-workspace-right = ["<Super>Right"];
        show-desktop = ["<Super>d"];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Open Files";
        command = "nautilus --new-window";
        binding = "<Super>e";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "Open Terminal";
        command = "ghostty";
        binding = "<Super>backslash";
      };
    };
  };

  # Hide specific apps from GUI menus
  xdg = {
    enable = true;
    desktopEntries = {
      htop = {
        name = "htop";
        noDisplay = true;
      };
      neovim = {
        name = "Neovim wrapper";
        noDisplay = true;
      };
    };
  };
}
