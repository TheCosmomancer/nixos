{ config, pkgs, lib, ... }:
{
  options = {
    desktop.enable = 
      lib.mkEnableOption "enables desktop";
  };
  config = lib.mkIf config.desktop.enable {
    #DESKTOP APPS
    environment.systemPackages = with pkgs; [
    vlc
    libreoffice
    gimp-with-plugins
    inkscape-with-extensions
    obs-studio
    xreader
    nomacs
    peazip
    obsidian
    telegram-desktop
    discord
    bitwarden-desktop
    gparted
    gnome-font-viewer
    sublime-merge
    rustdesk
    nwg-look
    ghostty
    ];
    programs.xfconf.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;
    programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
        thunar-media-tags-plugin
        thunar-archive-plugin
        thunar-volman
        ];
    };
    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
      policies = {
        DontCheckDefaultBrowser = true;
        DisablePocket = true;
        SearchBar = "unified";
        AutofillCreditCardEnabled = false;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        OfferToSaveLogins = false;
        SkipTermsOfUse = true;
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "force_installed";
          };
          "extension@tabliss.io" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tabliss/latest.xpi";
          installation_mode = "force_installed";
          };
          "simple-tab-groups@drive4ik" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/simple-tab-groups/latest.xpi";
          installation_mode = "force_installed";
          };
        };
      };
    };




    #CLI TOOLS
    environment.systemPackages = with pkgs; [
    difftastic
    tlrc
    lazygit
    jq
    fzf
    fd
    playerctl
    mpc
    ];
    services.cloudflare-warp.enable = true;
    programs.yazi = {
      enable =true;
    };


    #FUN
    environment.systemPackages = with pkgs; [
    cockatrice
    lutris
    wineWowPackages.waylandFull
    dxvk_2
    steam
    mommy
    cmatrix
    cbonsai
    fastfetch
    neo
    #shadps4
    ];


    #THEMES
    environment.systemPackages = with pkgs; [
    bibata-cursors
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    gruvbox-kvantum
    rose-pine-kvantum
    gruvbox-gtk-theme
    gruvbox-plus-icons
    ];
    environment.sessionVariables = {
      QT_STYLE_OVERRIDE = "kvantum";
    };
    boot.loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;
            grub = {
                efiSupport = true;
                enable = true;
                useOSProber = true;
                device = "nodev";
            };
        };
    distro-grub-themes = {
        enable = true;
        theme = "hp-victus";
    };
    boot = {
            plymouth = {
                enable = true;
                theme = "owl";
                themePackages = with pkgs; [
                    # By default we would install all themes
                    (adi1090x-plymouth-themes.override {
                    selected_themes = [ "owl" ];
                    })
                ];
            };

            # Enable "Silent boot"
            consoleLogLevel = 3;
            initrd.verbose = false;
            kernelParams = [
                "quiet"
                "splash"
                "boot.shell_on_fail"
                "udev.log_priority=3"
                "rd.systemd.show_status=auto"
            ];
            # Hide the OS choice for bootloaders.
            # It's still possible to open the bootloader list by pressing any key
            # It will just not appear on screen unless a key is pressed
            loader.timeout = 5;
        };
      services.displayManager = {
      autoLogin = {
        enable = true;
        user = "cosmomancer";
      };
      sddm = {
        enable = true;
        package = pkgs.libsForQt5.sddm;
        wayland.enable = true;
        autoNumlock = true;
        autoLogin.relogin = true;
        # sugarCandyNix = {
        #   enable = true;
        #   settings = {
        #     Background = /etc/nixos/media/astronautgarden.png;
        #     ScreenWidth = 1920;
        #     ScreenHeight = 1080;
        #     FormPosition = "left";
        #     MainColor = "white";
        #     AccentColor = "black";
        #     # OverrideLoginButtonTextColor = "";
        #     HeaderText = "";
        #     DateFormat = "dddd, MMMM d, yyyy";
        #   };
        # };
      };
    };
    


    #SYSTEM
    environment.systemPackages = with pkgs; [
    lm_sensors
    btop
    networkmanagerapplet
    brightnessctl
    # bluez
    ];
    networking.networkmanager.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
    time.timeZone = "Asia/Tehran";
    i18n.defaultLocale = "en_US.UTF-8";
    services.printing.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
      # use the example session manager (no others are packaged yet so this is enabled by default,no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];
    programs.nh = {
      enable = true;
      clean= {
        enable = true;
        extraArgs = "--keep 5";
        dates = "weekly";
      };
      flake = "/etc/nixos/";
    };
  };
}