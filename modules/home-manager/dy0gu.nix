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
    celluloid # Video player, supports most formats
    handbrake # GUI over ffmpeg for minor video editing, compression and conversion
    switcheroo # Image resizer and format converter
    curtail # Image compression tool
    gaphor # UML, SysML, RAAML and C4 diagram editor
    onlyoffice-desktopeditors # Office suite, alternative to LibreOffice
    libreoffice-fresh # Office suite
    impression # Bootable drive creator
    share-preview # Local previewer for open graph cards
    fragments # BitTorrent client
    mailspring # Email client
    discord
    blender

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
      title = "  ";
      font-family = "FiraCode Nerd Font";
      window-subtitle = "working-directory";
      gtk-single-instance = true;
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
    ];
  };

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

      "org/gnome/system/location" = {
        enabled = true;
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
          "color-picker@tuberry"
          "Vitals@CoreCoding.com"
          "caffeine@patapon.info"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.TextEditor.desktop"
          "org.gnome.Settings.desktop"
        ];
      };

      "org/gnome/desktop/input-sources" = {
        xkb-options = [
          "compose:menu"
        ];
      };

      "org/gnome/desktop/wm/keybindings" = {
        move-to-monitor-down = [];
        move-to-monitor-left = [];
        move-to-monitor-right = [];
        move-to-monitor-up = [];
        move-to-workspace-1 = [];
        move-to-workspace-2 = [];
        move-to-workspace-down = [];
        move-to-workspace-last = [];
        move-to-workspace-left = [];
        move-to-workspace-right = [];
        move-to-workspace-up = [];
        switch-to-workspace-left = ["<Super>Left"];
        switch-to-workspace-right = ["<Super>Right"];
        panel-run-dialog = [ "<Super>r" ];
        always-on-top = [ "<Super>p" ];
        show-desktop = ["<Super>d"];
        toggle-fullscreen = [ "<Super>f" ];
        close = ["<Super>q"];

      };

      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
        switch-to-application-5 = [];
        switch-to-application-6 = [];
        switch-to-application-7 = [];
        switch-to-application-8 = [];
        switch-to-application-9 = [];
        screenshot = [ "Print" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        ];
        logout = [ "<Control><Alt>Delete" ];
        screensaver = [ "<Super>l" ];
        # "battery-status"
        # "calculator"
        # "control-center"
        # "decrease-text-size"
        # "eject"
        # "email"
        # "help"
        # "hibernate"
        # "home"
        # "increase-text-size"
        # "keyboard-brightness-down"
        # "keyboard-brightness-toggle"
        # "keyboard-brightness-up"
        # "logout"
        # "magnifier"
        # "magnifier-zoom-in"
        # "magnifier-zoom-out"
        # "media"
        # "mic-mute"
        # "next"
        # "on-screen-keyboard"
        # "pause"
        # "play"
        # "playback-forward"
        # "playback-random"
        # "playback-repeat"
        # "playback-rewind"
        # "power"
        # "previous"
        # "rfkill"
        # "rfkill-bluetooth"
        # "rotate-video-lock"
        # "screen-brightness-cycle"
        # "screen-brightness-down"
        # "screen-brightness-up"
        # "screenreader"
        # "screensaver"
        # "search"
        # "stop"
        # "suspend"
        # "toggle-contrast"
        # "touchpad-off"
        # "touchpad-on"
        # "touchpad-toggle"
        # "volume-down"
        # "volume-down-precise"
        # "volume-down-quiet"
        # "volume-mute"
        # "volume-mute-quiet"
        # "volume-step"
        # "volume-up"
        # "volume-up-precise"
        # "volume-up-quiet"
        # "www"
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

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        name = "Open Special Characters";
        command = "gnome-characters";
        binding = "<Super>.";
      };
    };
  };

  # Hide specific apps from GUI menus
  xdg = {
    enable = true;
    # Names used to reference .desktop files here must be an exact match to the nixpackgs derivation that provides them
    desktopEntries = {
      gimp = {
        name = "GIMP";
      };
      swriter = {
        name = "LibreOffice Writer";
        noDisplay = true;
      };
      swriter = {
        name = "LibreOffice Writer";
        noDisplay = true;
      };
      swriter = {
        name = "LibreOffice Writer";
        noDisplay = true;
      };
      swriter = {
        name = "LibreOffice Writer";
        noDisplay = true;
      };
      sbase = {
        name = "LibreOffice Base";
        noDisplay = true;
      };
      smath = {
        name = "LibreOffice Math";
        noDisplay = true;
      };
      htop = {
        name = "htop";
        noDisplay = true;
      };
      nvim = {
        name = "Neovim wrapper";
        noDisplay = true;
      };
    };
  };
}
