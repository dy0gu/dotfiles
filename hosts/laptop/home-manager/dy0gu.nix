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

    # Development tools
    gh # GitHub CLI
    glab # GitLab CLI
    # Programming language installations are managed with nix-shell(s) on a per-project basis as is the Nix way
    # See the ./shells folder in the repository root for examples

    # InfoSec tools
    nmap # Network scanner
    wireshark # Network protocol analyzer
    aircrack-ng # Wireless security suite
    sqlmap # SQL injection tool
    john # Password cracker
    metasploit # Pentesting framework
    zap # Web application security scanner

    # Gnome extensions
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.color-picker
    gnomeExtensions.caffeine
    gnomeExtensions.vitals

    # Applications
    discord
    gns3-gui
  ];

  # More applications that have built-in home-manager enablement and configuration
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
        bindings = {
          ctrl-j = null;
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
      theme = "dark:Adwaita Dark,light:Adwaita";
      background = "#222226";
      font-family = "FiraCode Nerd Font";
      title = " ";
      window-subtitle = false;
      confirm-close-surface = false;
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
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl+l=clear_screen"
      ];
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

  programs.lazydocker = {
    enable = true;
  };

  # Gnome settings using dconf
  # Run "nix-shell -p dconf-editor" and then "dconf-editor" inside it to get a GUI that shows all the keys that can be edited here
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
        fallback-logo = " ";
        logo = " ";
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

      "org/gnome/desktop/sound" = {
        allow-volume-above-100-percent = true;
        event-sounds = false;
        input-feedback-sounds = false;
      };

      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
      };

      "org/gnome/desktop/a11y" = {
        always-show-universal-access-status = true;
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

       "org/gnome/desktop/default-applications/terminal" = {
          exec = "ghostty";
        };

      # Gnome applications settings
      "org/gnome/Geary" = {
        run-in-background = false; # setting to true is cool for background notifications but also makes it open on boot so disable for now
        optional-plugins = [
          "email-templates"
          "mail-merge"
        ];
      };

      "org/gnome/shell" = {
        allow-extension-installation = true;
        disable-user-extensions = false;
        enabled-extensions = [
          "clipboard-indicator@tudmotu.com"
          "color-picker@tuberry"
          "Vitals@CoreCoding.com"
          "caffeine@patapon.info"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
        favorite-apps = [
          # "firefox.desktop"
          # "org.gnome.Nautilus.desktop"
          # "org.gnome.TextEditor.desktop"
          # "org.gnome.Settings.desktop"
        ];
      };

      # Gnome extension settings
      "org/gnome/shell/extensions/clipboard-indicator" = {
        cache-size = 20;
        history-size = 80;
        preview-size = 30;
        display-mode = 0;
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

      "org/gnome/shell/extensions/caffeine" = {
        duration-timer = 2;
        duration-timer-list = [
          900
          1800
          3600
        ];
        enable-fullscreen = true;
        enable-mpris = true;
        indicator-position-max = 1;
        show-indicator = "always";
        show-notifications = false;
        show-toggle = true;
        toggle-shortcut = [ "<Super><Control>c" ];
        user-enabled = false;
      };

      "org/gnome/shell/extensions/color-picker" = {
        color-picker-shortcut = [ "<Super><Control>p" ];
        custom-formats = [
          "<{ 'enable' = <true>; 'name' = <'HSV'>; 'format' = <'hsv({Hu}, {Sv}, {Va})'>; }>"
          "<{ 'enable' = <true>; 'name' = <'CMYK'>; 'format' = <'cmyk({Cy}, {Ma}, {Ye}, {Bk})'>; }>"
        ];
        default-format = 0;
        enable-format = false;
        enable-notify = true;
        enable-shortcut = true;
        enable-systray = true;
        notify-style = 1;
        persistent-mode = true;
        preview-style = 0;
      };

      "org/gnome/shell/extensions/vitals" = {
        alphabetize = true;
        fixed-widths = true;
        hide-icons = false;
        hide-zeros = true;
        hot-sensors = [
          "_memory_usage_"
          "_processor_usage_"
        ];
        icon-style = 1;
        include-public-ip = false;
        include-static-info = true;
        menu-centered = false;
        network-speed-format = 0;
        position-in-panel = 4;
        show-fan = true;
        show-gpu = true;
        show-memory = true;
        show-network = true;
        show-processor = true;
        show-storage = false;
        show-system = true;
        show-temperature = true;
        show-battery = false;
        use-higher-precision = false;
      };

      "org/gnome/shell/extensions/appindicator" = {
        icon-brightness = 0;
        icon-contrast = 0.3;
        icon-opacity = 255;
        icon-saturation = 1;
        icon-size = 22;
        tray-pos = "left";
      };

      "org/gnome/desktop/input-sources" = {
        xkb-options = [
          "compose:menu"
        ];
      };

      "org/gnome/desktop/wm/keybindings" = {
        move-to-monitor-down = [ ];
        move-to-monitor-left = [ ];
        move-to-monitor-right = [ ];
        move-to-monitor-up = [ ];
        move-to-workspace-down = [ ];
        move-to-workspace-last = [ ];
        move-to-workspace-left = [ ];
        move-to-workspace-right = [ ];
        move-to-workspace-up = [ ];
        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
        switch-to-workspace-left = [ ];
        switch-to-workspace-right = [ ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        maximize = [ "<Super>Up" ];
        unmaximize = [ "<Super>Down" ];
        view-split-on-right = [ "<Super>Right" ];
        view-split-on-left = [ "<Super>Left" ];
        panel-run-dialog = [ "<Super>r" ];
        always-on-top = [ "<Super>p" ];
        show-desktop = [ "<Super>d" ];
        toggle-fullscreen = [ "<Super>f" ];
        close = [ "<Super>q" ];
      };

      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
        toggle-application-view = [ "<Super>a" ];
        toggle-quick-settings = [ "<Super>s" ];
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
        ];
        screensaver = [ "<Super>l" ];
        on-screen-keyboard = [ "<Super><Alt>k" ];
        magnifier = [ "<Alt><Shift>m" ];
        magnifier-zoom-in = [ "<Alt><Shift>q" ];
        magnifier-zoom-out = [ "<Alt><Shift>e" ];
        touchpad-toggle = [ "<Super>t" ];
        # "keyboard-brightness-down"
        # "keyboard-brightness-up"
        # "mic-mute"
        # "next"
        # "pause"
        # "play"
        # "stop"
        # "previous"
        # "playback-forward"
        # "playback-random"
        # "playback-repeat"
        # "playback-rewind"
        # "screen-brightness-down"
        # "screen-brightness-up"
        # "volume-down"
        # "volume-down-precise"
        # "volume-down-quiet"
        # "volume-mute"
        # "volume-mute-quiet"
        # "volume-step"
        # "volume-up"
        # "volume-up-precise"
        # "volume-up-quiet"
        calculator = [ ];
        battery-status = [ ];
        eject = [ ];
        email = [ ];
        help = [ ];
        screenreader = [ ];
        search = [ ];
        logout = [ ];
        suspend = [ ];
        hibernate = [ ];
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
        decrease-text-size = [ ];
        increase-text-size = [ ];
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
    # Keys used to reference .desktop files here must be an exact match to the nixpackg that provides them
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
