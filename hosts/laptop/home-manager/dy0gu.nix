{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.home-manager.enable = true;

  home.username = "dy0gu";
  home.homeDirectory = "/home/dy0gu";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # System utilities
    fastfetch
    pipes
    cmatrix

    # Development tools
    gh # GitHub CLI
    glab # GitLab CLI
    kubectl # Kubernetes CLI
    # Programming language installations are managed with nix-shell(s) on a per-project basis as is the Nix way
    # See the ./shells folder in the repository root for examples

    # InfoSec tools
    wireshark # Network protocol analyzer
    aircrack-ng # Wireless security suite
    sqlmap # SQL injection tool
    john # Password cracker
    metasploit # Pentesting framework for known vulnerabilities
    burpsuite # Web security testing tool

    # Gnome extensions
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.lock-keys
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.just-perfection

    # Applications
    discord
  ];

  # User specific services
  services.podman = {
    enable = true;
    enableTypeChecks = true;
    autoUpdate = {
      enable = false;
    };
  };

  # More applications that have built-in home-manager enablement and configuration
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
    ];
  };

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;
    installRemoteServer = false;
    # Restart Zed sometime after the first boot so it installs these extensions that will be downloaded in the background
    extensions = [
      "angular"
      "ansible"
      "assembly"
      "astro"
      "csharp"
      "dart"
      "docker-compose"
      "dockerfile"
      "edge"
      "elisp"
      "elixir"
      "elm"
      "ember"
      "env"
      "erlang"
      "fsharp"
      "gdscript"
      "git-firefly"
      "gleam"
      "glsl"
      "go"
      "gosum"
      "graphql"
      "groovy"
      "haml"
      "haskell"
      "html"
      "hyprlang"
      "ical"
      "ini"
      "java"
      "json5"
      "jsonnet"
      "julia"
      "just"
      "kotlin"
      "latex"
      "liquid"
      "log"
      "logstash"
      "lua"
      "make"
      "markdown-oxide"
      "material-icon-theme"
      "mcp-server-context7"
      "neocmake"
      "nginx"
      "nim"
      "nix"
      "nu"
      "odin"
      "opentofu"
      "perl"
      "php"
      "powershell"
      "proto"
      "purescript"
      "pylsp"
      "python-requirements"
      "qml"
      "rainbow-csv"
      "rst"
      "ruby"
      "scala"
      "scheme"
      "scss"
      "slint"
      "snippets"
      "sorbet"
      "solidity"
      "starlark"
      "svelte"
      "swift"
      "templ"
      "tera"
      "termux"
      "terraform"
      "toml"
      "typespec"
      "verilog"
      "vue"
      "xml"
      "zedokai"
      "zig"
    ];
    # LSPs, linters and formatters that don't come with the respective extensions but are needed for them to work
    extraPackages = with pkgs; [
      # Nix
      nixd
      nixfmt-rfc-style
      # Python
      black
    ];
    userSettings = {
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      buffer_font_family = "FiraCode Nerd Font";
      theme = {
        mode = "system";
        light = "One Light";
        dark = "Zedokai (Filter Spectrum)";
      };
      icon_theme = "Material Icon Theme";
      ui_font_size = 18;
      buffer_font_size = 18;
      vim_mode = false;
      autosave = "off";
      restore_on_startup = "none";
      auto_update = false;
      base_keymap = "VSCode";
      features = {
        edit_prediction_provider = "zed";
      };
      collaboration_panel = {
        button = false;
      };
      chat_panel = {
        button = "never";
      };
      outline_panel = {
        button = false;
      };
      terminal = {
        button = false;
      };
      project_panel = {
        button = true;
        dock = "left";
      };
      git_panel = {
        button = true;
        dock = "left";
      };
      debugger = {
        button = true;
        dock = "left";
      };
      search = {
        button = true;
        dock = "left";
      };
      diagnostics = {
        button = true;
        include_warnings = true;
        inline = {
          enabled = true;
          update_debounce_ms = 150;
          padding = 4;
          min_column = 0;
          max_severity = null;
        };
      };
      agent = {
        button = true;
        dock = "right";
        model_parameters = [];
        play_sound_when_agent_done = false;
        version = "2";
      };
      notification_panel = {
        button = true;
        dock = "right";
      };
      languages = {
        Nix = {
          language_servers = [ "nixd" ];
          formatter = {
            external = {
              command = "nixfmt";
            };
          };
        };
        Python = {
          language_servers = [ "pyright" ];
          formatter = {
            external = {
              command = "black";
            };
          };
        };
      };
    };
    userKeymaps = [
      {
        # Hide terminal in panel and remove keybind, we intend to only use an external terminal
        # Maybe start using integrated terminal when it remembers the state it was closed in
        bindings = {
          ctrl-j = null;
          ctrl-r = "projects::OpenRecent";
        };
      }
    ];
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
      docker = "podman";
      pipes = "pipes.sh";
      matrix = "cmatrix";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
      ];
      theme = "strug";
    };
  };


  programs.ghostty = {
    enable = true;
    settings = {
      command = "zsh --login";
      theme = "dark:custom-adwaita-dark,light:custom-adwaita-light";
      font-family = "FiraCode Nerd Font";
      title = "Ghostty";
      window-subtitle = false;
      confirm-close-surface = false;
      gtk-single-instance = true;
      app-notifications = false;
      linux-cgroup = "single-instance";
      adw-toolbar-style = "flat";
      auto-update = "off";
      clipboard-trim-trailing-spaces = true;
      keybind = [
        "ctrl+tab=new_tab"
        "ctrl+left=previous_tab"
        "ctrl+right=next_tab"
        "alt+left=goto_split:left"
        "alt+right=goto_split:right"
        "alt+up=goto_split:up"
        "alt+down=goto_split:down"
        "shift+alt+left=new_split:left"
        "shift+alt+right=new_split:right"
        "shift+alt+up=new_split:up"
        "shift+alt+down=new_split:down"
        "ctrl+w=close_surface"
        "ctrl+q=close_window"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl+l=clear_screen"
      ];
    };
    themes = {
      custom-adwaita-dark = {
        background = "222226";
        foreground = "ffffff";
        cursor-color = "ffffff";
        cursor-text = "1e1e1e";
        selection-background = "ffffff";
        selection-foreground = "5e5c64";
        palette = [
          "0=#241f31"
          "1=#c01c28"
          "2=#2ec27e"
          "3=#f5c211"
          "4=#1e78e4"
          "5=#9841bb"
          "6=#0ab9dc"
          "7=#c0bfbc"
          "8=#5e5c64"
          "9=#ed333b"
          "10=#57e389"
          "11=#f8e45c"
          "12=#51a1ff"
          "13=#c061cb"
          "14=#4fd2fd"
          "15=#f6f5f4"
        ];
      };
      custom-adwaita-light = {
        background = "fffafb";
        foreground = "000000";
        cursor-color = "000000";
        cursor-text = "ffffff";
        selection-background = "c0bfbc";
        selection-foreground = "000000";
        palette = [
          "0=#2b253a"
          "1=#b31b25"
          "2=#28b973"
          "3=#ddb90f"
          "4=#1c6fce"
          "5=#8a3aa9"
          "6=#08a5c4"
          "7=#b3b2b0"
          "8=#545258"
          "9=#d52e36"
          "10=#4ed17d"
          "11=#e9d94f"
          "12=#4694e6"
          "13=#ac58b8"
          "14=#45bde6"
          "15=#eae9e8"
        ];
      };
    };
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

  # Default applications for the desktop environment
  # xdg.mime.enable = true;
  # xdg.mimeApps.defaultApplications = {
  #   x-scheme-handler/http=firefox.desktop
  #   text/html=firefox.desktop
  #   application/xhtml+xml=firefox.desktop
  #   x-scheme-handler/https=firefox.desktop
  #   audio/x-vorbis+ogg=org.gnome.Decibels.desktop
  #   audio/mpeg=org.gnome.Decibels.desktop
  #   audio/wav=org.gnome.Decibels.desktop
  #   audio/x-aac=org.gnome.Decibels.desktop
  #   audio/x-aiff=org.gnome.Decibels.desktop
  #   audio/x-ape=org.gnome.Decibels.desktop
  #   audio/x-flac=org.gnome.Decibels.desktop
  #   audio/x-m4a=org.gnome.Decibels.desktop
  #   audio/x-m4b=org.gnome.Decibels.desktop
  #   audio/x-mp1=org.gnome.Decibels.desktop
  #   audio/x-mp2=org.gnome.Decibels.desktop
  #   audio/x-mp3=org.gnome.Decibels.desktop
  #   audio/x-mpg=org.gnome.Decibels.desktop
  #   audio/x-mpeg=org.gnome.Decibels.desktop
  #   audio/x-mpegurl=org.gnome.Decibels.desktop
  #   audio/x-opus+ogg=org.gnome.Decibels.desktop
  #   audio/x-pn-aiff=org.gnome.Decibels.desktop
  #   audio/x-pn-au=org.gnome.Decibels.desktop
  #   audio/x-pn-wav=org.gnome.Decibels.desktop
  #   audio/x-speex=org.gnome.Decibels.desktop
  #   audio/x-vorbis=org.gnome.Decibels.desktop
  #   audio/x-wavpack=org.gnome.Decibels.desktop
  #   image/jpeg=org.gnome.Loupe.desktop
  #   image/png=org.gnome.Loupe.desktop
  #   image/gif=org.gnome.Loupe.desktop
  #   image/webp=org.gnome.Loupe.desktop
  #   image/tiff=org.gnome.Loupe.desktop
  #   image/x-tga=org.gnome.Loupe.desktop
  #   image/vnd-ms.dds=org.gnome.Loupe.desktop
  #   image/x-dds=org.gnome.Loupe.desktop
  #   image/bmp=org.gnome.Loupe.desktop
  #   image/vnd.microsoft.icon=org.gnome.Loupe.desktop
  #   image/vnd.radiance=org.gnome.Loupe.desktop
  #   image/x-exr=org.gnome.Loupe.desktop
  #   image/x-portable-bitmap=org.gnome.Loupe.desktop
  #   image/x-portable-graymap=org.gnome.Loupe.desktop
  #   image/x-portable-pixmap=org.gnome.Loupe.desktop
  #   image/x-portable-anymap=org.gnome.Loupe.desktop
  #   image/x-qoi=org.gnome.Loupe.desktop
  #   image/qoi=org.gnome.Loupe.desktop
  #   image/svg+xml=org.gnome.Loupe.desktop
  #   image/svg+xml-compressed=org.gnome.Loupe.desktop
  #   image/avif=org.gnome.Loupe.desktop
  #   image/heic=org.gnome.Loupe.desktop
  #   image/jxl=org.gnome.Loupe.desktop
  #   video/x-ogm+ogg=io.github.celluloid_player.Celluloid.desktop
  #   video/ogg=io.github.celluloid_player.Celluloid.desktop
  #   video/x-theora+ogg=io.github.celluloid_player.Celluloid.desktop
  #   video/x-theora=io.github.celluloid_player.Celluloid.desktop
  #   video/x-ms-asf=io.github.celluloid_player.Celluloid.desktop
  #   video/x-ms-wm=io.github.celluloid_player.Celluloid.desktop
  #   video/x-ms-wmv=io.github.celluloid_player.Celluloid.desktop
  #   video/x-ms-wmx=io.github.celluloid_player.Celluloid.desktop
  #   video/x-msvideo=io.github.celluloid_player.Celluloid.desktop
  #   video/divx=io.github.celluloid_player.Celluloid.desktop
  #   video/msvideo=io.github.celluloid_player.Celluloid.desktop
  #   video/x-avi=io.github.celluloid_player.Celluloid.desktop
  #   video/vnd.rn-realvideo=io.github.celluloid_player.Celluloid.desktop
  #   video/mp2t=io.github.celluloid_player.Celluloid.desktop
  #   video/mpeg=io.github.celluloid_player.Celluloid.desktop
  #   video/mpeg-system=io.github.celluloid_player.Celluloid.desktop
  #   video/x-mpeg=io.github.celluloid_player.Celluloid.desktop
  #   video/x-mpeg2=io.github.celluloid_player.Celluloid.desktop
  #   video/x-mpeg-system=io.github.celluloid_player.Celluloid.desktop
  #   video/mp4=io.github.celluloid_player.Celluloid.desktop
  #   video/mp4v-es=io.github.celluloid_player.Celluloid.desktop
  #   video/x-m4v=io.github.celluloid_player.Celluloid.desktop
  #   video/quicktime=io.github.celluloid_player.Celluloid.desktop
  #   video/x-matroska=io.github.celluloid_player.Celluloid.desktop
  #   video/webm=io.github.celluloid_player.Celluloid.desktop
  #   video/3gp=io.github.celluloid_player.Celluloid.desktop
  #   video/3gpp=io.github.celluloid_player.Celluloid.desktop
  #   video/3gpp2=io.github.celluloid_player.Celluloid.desktop
  #   video/vnd.mpegurl=io.github.celluloid_player.Celluloid.desktop
  #   video/dv=io.github.celluloid_player.Celluloid.desktop
  #   video/x-nsv=io.github.celluloid_player.Celluloid.desktop
  #   video/fli=io.github.celluloid_player.Celluloid.desktop
  #   video/flv=io.github.celluloid_player.Celluloid.desktop
  #   video/x-flc=io.github.celluloid_player.Celluloid.desktop
  #   video/x-fli=io.github.celluloid_player.Celluloid.desktop
  #   video/x-flv=io.github.celluloid_player.Celluloid.desktop
  # };

  # Gnome settings using dconf
  # Use "dconf watch /" to see the keys that are being changed while you play around with the Gnome settings to later write them here
  # You can also run "nix-shell -p dconf-editor" and then "dconf-editor" inside it to get a GUI that shows all
  # the keys that have been created or edited
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-opacity = 100;
        picture-options = "zoom";
        picture-uri = "file:///home/dy0gu/.dotfiles/wallpapers/adwaita-l.jxl";
        picture-uri-dark = "file:///home/dy0gu/.dotfiles/wallpapers/adwaita-d.jxl";
        primary-color = "#241f31";
        secondary-color = "#222226";
        show-desktop-icons = false;
      };

      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-opacity = 100;
        picture-options = "zoom";
        primary-color = "#241f31";
        secondary-color = "#222226";
        picture-uri = "file:///home/dy0gu/.dotfiles/wallpapers/adwaita-l.jxl";
        show-full-name-in-top-bar = true;
        status-messages-enabled = true;
        user-switch-enabled = true;
      };

      "org/gnome/desktop/privacy" = {
      };

      "org/gnome/desktop/break-reminders" = {
      };


      "org/gnome/desktop/calendar" = {
        show-weekdate = false;
      };

      "org/gnome/desktop/notifications" = {
        show-banners = true;
        show-in-lock-screen = true;
      };

      "org/gnome/desktop/screen-time-limits" = {
        daily-limit-enabled = false;
        daily-limit-seconds = 0;
        grayscale = true;
        history-enabled = true;
      };

      "org/gnome/desktop/media-handling" = {
        automount = true;
        automount-open = true;
        autorun-never = true;
      };

      "org/gnome/desktop/datetime" = {
        automatic-timezone = true;
      };

      "org/gnome/login-screen" = {
        banner-message-enable = false;
      };

      "org/gnome/desktop/peripherals/mouse" = {
        # Disable mouse acceleration
        accel-profile = "flat";
        left-handed = false;
      };

      "org/gnome/system/location" = {
        enabled = true;
      };

      "org/gnome/desktop/a11y" = {
        always-show-universal-access-status = true;
      };

      "org/gnome/desktop/app-folders" = {
        # Disable folders
        folder-children = [""];
      };

      "org/gnome/desktop/sound" = {
        allow-volume-above-100-percent = true;
        event-sounds = false;
        input-feedback-sounds = false;
        theme-name = "freedesktop";
      };

      "org/gnome/shell/app-switcher" = {
        current-workspace-only = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        action-double-click-titlebar = "toggle-maximize";
        action-middle-click-titlebar = "toggle-maximize";
        action-right-click-titlebar = "menu";
        audible-bell = false;
        auto-raise = true;
        auto-raise-delay = 300;
        button-layout = "appmenu:minimize,maximize,close";
        disable-workarounds = false;
        focus-mode = "click";
        focus-new-windows = "smart";
        mouse-button-modifier = "<Super>";
        num-workspaces = 5;
        workspace-names = [];
        raise-on-click = true;
        resize-with-right-button = false;
        theme = "Adwaita";
        titlebar-uses-system-font = false;
        titlebar-font = "Adwaita Sans Bold 11";
        visual-bell = true;
        visual-bell-type = "frame-flash";
      };

      "org/gnome/desktop/interface" = {
        accent-color = "blue";
        can-change-accels = false;
        clock-format = "24h";
        clock-show-date = true;
        clock-show-seconds = true;
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        cursor-blink = true;
        cursor-blink-time = 1200;
        cursor-blink-timeout = 10;
        cursor-size = 24;
        cursor-theme = "Adwaita";
        document-font-name = "Adwaita Sans 11";
        enable-animations = true;
        enable-hot-corners = false;
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        font-name = "Adwaita Sans 11";
        font-rendering = "automatic";
        font-rgba-order = "rgb";
        gtk-color-scheme = "";
        gtk-enable-primary-paste = true;
        gtk-theme = "Adwaita";
        gtk-timeout-initial = 200;
        gtk-timeout-repeat = 20;
        icon-theme = "Adwaita";
        menubar-accel = "F10";
        menubar-detachable = false;
        menus-have-tearoff = false;
        monospace-font-name = "Adwaita Mono 11";
        overlay-scrolling = true;
        scaling-factor = 0;
        show-battery-percentage = true;
        text-scaling-factor = 1.0;
        toolbar-detachable = false;
        toolbar-icons-size = "large";
        toolbar-style = "both-horiz";
        toolkit-accessibility = true;
      };

      "org/gnome/mutter" = {
        attach-modal-dialogs = true;
        auto-maximize = true;
        center-new-windows = true;
        check-alive-timeout = 5000;
        draggable-border-width = 10;
        dynamic-workspaces = false;
        edge-tiling = false;
        experimental-features = [ ];
        focus-change-on-pointer-rest = true;
        locate-pointer = false;
        locate-pointer-key = "";
        overlay-key = "Super";
        workspaces-only-on-primary = true;
      };


      "org/gnome/desktop/default-applications/terminal" = {
        exec = "ghostty";
      };

      "org/gnome/shell" = {
        allow-extension-installation = true;
        disable-user-extensions = false;
        always-show-log-out = true;
        development-tools = true;
        # The UUIDs needed here can be found by looking at the metadata.json in the extension source code repository
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "clipboard-indicator@tudmotu.com"
          "lockkeys@vaina.lt"
          "AlphabeticalAppGrid@stuarthayhurst"
          "just-perfection-desktop@just-perfection"
        ];
        favorite-apps =  [
          "firefox.desktop"
          "dev.zed.Zed.desktop"
          "com.mitchellh.ghostty.desktop"
        ];
      };

      # Gnome extension settings
      "org/gnome/shell/extensions/clipboard-indicator" = {
        cache-size = 20;
        history-size = 80;
        preview-size = 30;
        display-mode = 3;
        clear-on-boot = false;
        confirm-clear = false;
        disable-down-arrow = true;
        keep-selected-on-clear = true;
        move-item-first = false;
        notify-on-copy = false;
        notify-on-cycle = false;
        paste-button = false;
        paste-on-select = false;
        pinned-on-bottom = false;
        strip-text = false;
        toggle-menu = [ "<Super>v" ];
        next-entry = [ ];
        prev-entry = [ ];
        private-mode-binding = [ ];
        clear-history = [ ];
      };

      "org/gnome/shell/extensions/appindicator" = {
        icon-brightness = 0;
        icon-contrast = 0.3;
        icon-opacity = 255;
        icon-saturation = 1;
        icon-size = 21;
        tray-pos = "left";
      };

      "org/gnome/shell/extensions/just-perfection" = {
        accent-color-icon = false;
        accessibility-menu = true;
        activities-button = false;
        animation = 5;
        dash = true;
        dash-app-running = true;
        dash-separator = true;
        double-super-to-appgrid = false;
        quick-settings-dark-mode = true;
        quick-settings-airplane-mode = true;
        max-displayed-search-results = 2;
        ripple-box = false;
        search = true;
        osd = true;
        osd-position = 5;
        notification-banner-position = 1;
        power-icon = true;
        overlay-key = true;
        panel = false;
        panel-in-overview = true;
        panel-notification-icon = true;
        show-apps-button = true;
        startup-status = 1;
        support-notifier-type = 0;
        switcher-popup-delay = true;
        invert-calendar-column-items = false;
        keyboard-layout = true;
        theme = false;
        top-panel-position = 0;
        type-to-search = true;
        weather = true;
        window-demands-attention-focus = true;
        window-picker-icon = false;
        window-preview-caption = false;
        window-preview-close-button = true;
        workspace = false;
        workspace-peek = true;
        workspace-popup = true;
        workspaces-in-app-grid = true;
        workspace-switcher-should-show = true;
        workspace-wrap-around = false;
        world-clock = false;
      };

      "org/gnome/shell/extensions/lockkeys" = {
        notification-preferences = "osd";
        style = "none";
      };

      "org/gnome/desktop/input-sources" = {
        xkb-options = [
          "compose:menu"
          "lv3:ralt_switch"
        ];
      };

      "org/gnome/mutter/keybindings" = {
        cancel-input-capture = [ ];
        rotate-monitor = [];
        switch-monitor = [];
        toggle-tiled-left = [ "<Super>Left" ];
        toggle-tiled-right = [ "<Super>Right" ];
      };

      "org/gnome/mutter/wayland/keybindings" = {
        restore-shortcuts = [];
      };

      "org/gnome/desktop/wm/keybindings" = {
        maximize = ["<Super>Up" ];
        unmaximize = [ "<Super>Down" ];
        activate-window-menu = [ "<Alt>space" ];
        begin-move = [ "<Alt>F1" ];
        begin-resize = [ "<Alt>F2" ];
        switch-applications = [ "<Alt>Tab" "<Super>Tab" ];
        switch-applications-backward = [];
        switch-input-source = [];
        switch-input-source-backward = [];
        cycle-group = [ ];
        cycle-group-backward = [ ];
        cycle-panels = [ ];
        cycle-panels-backward = [ ];
        cycle-windows = [ ];
        cycle-windows-backward = [ ];
        raise = [];
        lower = [];
        raise-or-lower = [];
        maximize-horizontally = [];
        switch-group = [];
        switch-group-backward = [];
        maximize-vertically = [];
        move-to-center = [];
        move-to-corner-ne = [ ];
        move-to-corner-nw = [ ];
        move-to-corner-se = [ ];
        move-to-corner-sw = [ ];
        move-to-side-e = [ ];
        move-to-side-n = [ ];
        move-to-side-s = [];
        move-to-side-w = [ ];
        move-to-monitor-down = [ ];
        move-to-monitor-left = [ ];
        move-to-monitor-right = [ ];
        move-to-monitor-up = [ ];
        move-to-workspace-down = [ ];
        move-to-workspace-last = [ ];
        move-to-workspace-left = [ ];
        move-to-workspace-right = [ ];
        move-to-workspace-up = [ ];
        move-to-workspace-1 = [ "<Super><Ctrl>1" ];
        move-to-workspace-2 = [ "<Super><Ctrl>2" ];
        move-to-workspace-3 = [ "<Super><Ctrl>3" ];
        move-to-workspace-4 = [ "<Super><Ctrl>4" ];
        move-to-workspace-5 = [ "<Super><Ctrl>5" ];
        move-to-workspace-6 = [ "<Super><Ctrl>6" ];
        move-to-workspace-7 = [ "<Super><Ctrl>7" ];
        move-to-workspace-8 = [ "<Super><Ctrl>8" ];
        move-to-workspace-9 = [ "<Super><Ctrl>9" ];
        move-to-workspace-10 = [ "<Super><Ctrl>0" ];
        move-to-workspace-11 = [ ];
        move-to-workspace-12 = [ ];
        switch-to-workspace-left = [ ];
        switch-to-workspace-right = [ ];
        switch-to-workspace-1 = [ "<Super><Shift>1" ];
        switch-to-workspace-2 = [ "<Super><Shift>2" ];
        switch-to-workspace-3 = [ "<Super><Shift>3" ];
        switch-to-workspace-4 = [ "<Super><Shift>4" ];
        switch-to-workspace-5 = [ "<Super><Shift>5" ];
        switch-to-workspace-6 = [ "<Super><Shift>6" ];
        switch-to-workspace-7 = [ "<Super><Shift>7" ];
        switch-to-workspace-8 = [ "<Super><Shift>8" ];
        switch-to-workspace-9 = [ "<Super><Shift>9" ];
        switch-to-workspace-10 = [ "<Super><Shift>0" ];
        switch-to-workspace-11 = [ ];
        switch-to-workspace-12 = [ ];
        switch-to-workspace-down = [ ];
        switch-to-workspace-up = [ ];
        switch-to-workspace-last = [ ];
        toggle-on-all-workspaces = [];
        switch-panels = [ ];
        switch-panels-backward = [ ];
        toggle-maximized = [ "<Super>m" ];
        minimize = [ "<Super>h" ];
        panel-run-dialog = [ "<Super>r" ];
        always-on-top = [  ];
        toggle-above = [ ];
        show-desktop = [ "<Super>d" ];
        toggle-fullscreen = [ "<Super>f" ];
        close = [ "<Super>q" ];
      };

      "org/gnome/shell/keybindings" = {
        toggle-application-view = [ "<Super>a" ];
        toggle-quick-settings = [];
        toggle-message-tray = [ ];
        toggle-overview = [];
        focus-active-notification = [];
        open-new-window-application-1 = [];
        open-new-window-application-2 = [];
        open-new-window-application-3 = [];
        open-new-window-application-4 = [];
        open-new-window-application-5 = [];
        open-new-window-application-6 = [];
        open-new-window-application-7 = [];
        open-new-window-application-8 = [];
        open-new-window-application-9 = [];
        shift-overview-down = [];
        shift-overview-up = [];
        switch-to-application-1 = [ "<Super>1" ];
        switch-to-application-2 = [ "<Super>2" ];
        switch-to-application-3 = [ "<Super>3" ];
        switch-to-application-4 = [ "<Super>4" ];
        switch-to-application-5 = [ "<Super>5" ];
        switch-to-application-6 = [ "<Super>6" ];
        switch-to-application-7 = [ "<Super>7" ];
        switch-to-application-8 = [ "<Super>8" ];
        switch-to-application-9 = [ "<Super>9" ];
        show-screenshot-ui = [ "Print" ];
        screenshot-window = [ "<Shift>Print" ];
        screenshot = [ ];
        show-screen-recording-ui = [ ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
        ];
        volume-down-precise = [ "<Alt>F3" ];
        volume-up-precise = [ "<Alt>F4" ];
        volume-mute = [ "<Alt>F5" ];
        mic-mute = [ "<Alt>F6" ];
        play = [ "<Alt>F7" ];
        next = [ "<Alt>F8" ];
        previous = [ "<Alt>F9" ];
        touchpad-toggle = [ "<Alt>F10" ];
        screen-brightness-down = [ "<Alt>F11" ];
        screen-brightness-up = [ "<Alt>F12" ];
        keyboard-brightness-down = [];
        keyboard-brightness-up = [];
        playback-forward = [  ];
        playback-random = [  ];
        playback-repeat = [  ];
        playback-rewind = [  ];
        volume-step = [  ];
        volume-up = [  ];
        volume-up-quiet = [  ];
        volume-down = [  ];
        volume-down-quiet = [  ];
        volume-mute-quiet = [  ];
        screensaver = [ "<Super>l" ];
        on-screen-keyboard = [ "<Super><Alt>k" ];
        magnifier = [ "<Alt><Shift>m" ];
        magnifier-zoom-in = [ "<Alt><Shift>q" ];
        magnifier-zoom-out = [ "<Alt><Shift>e" ];
        decrease-text-size = [ "<Alt><Shift>minus" ];
        increase-text-size = [ "<Alt><Shift>equal" ];
        rfkill = [ ];
        rfkill-bluetooth = [ ];
        calculator = [ ];
        battery-status = [ ];
        eject = [ ];
        email = [ ];
        help = [ ];
        screenreader = [ ];
        www = [ ];
        search = [ ];
        logout = [ ];
        suspend = [ ];
        hibernate = [ ];
        reboot = [ ];
        shutdown = [ ];
        power = [ ];
        home = [ ];
        media = [ ];
        control-center = [ ];
        rotate-video-lock = [ ];
        touchpad-off = [ ];
        touchpad-on = [ ];
        toggle-contrast = [ ];
        screen-brightness-cycle = [ ];
        keyboard-brightness-toggle = [ ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Open Files";
        command = "nautilus";
        binding = "<Super>e";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "Open Settings";
        command = "gnome-control-center";
        binding = "<Super>s";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        name = "Open Special Characters";
        command = "gnome-characters";
        binding = "<Super>period";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        name = "Open System Monitor";
        command = "resources";
        binding = "<Shift><Control>Escape";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
        name = "Open Color Picker";
        command = "eyedropper";
        binding = "<Super>c";
      };
    };
  };

  # Hide specific apps from GUI menus
  xdg = {
    enable = true;
    # Keys used to reference .desktop files here must be an exact match to the nixpackage that provides them
    desktopEntries = {
      # Hide applications that don't belong in the GUI menu
      htop = {
        name = "htop";
        noDisplay = true;
      };
      nvtop = {
        name = "nvtop";
        noDisplay = true;
      };
      nvim = {
        name = "Neovim wrapper";
        noDisplay = true;
      };
    };
  };
}
