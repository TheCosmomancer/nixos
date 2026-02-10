{ config, pkgs, inputs, ... }:
{
    
  # SECTION: BASE

  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "io";
  users.users.cosmomancer = {
    isNormalUser = true;
    description = "cosmomancer";
    extraGroups = [ "networkmanager" "wheel" "input" "libvirtd"];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  security.sudo.extraRules = [{
    users = [ "cosmomancer" ];
    commands = [
      {
        command = "ALL";
        options = [ "SETENV" "NOPASSWD" ];
      }
    ];
    }];
  services.libinput.enable = true;
    services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
    };
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs; };
    users = {
      "cosmomancer" ={
        home.username = "cosmomancer";
        home.homeDirectory = "/home/cosmomancer";
        nixpkgs.config.allowUnfree = true;
        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
        imports = [./home.nix];
        #just don't change this and you'll be fine
        home.stateVersion = "25.11";
      };
    };
  };
  #just don't change this and you'll be fine
  system.stateVersion = "25.11";

  #SECTION: DEVELOPMENT

  programs.nixvim = {
  enable = true;
  };
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
    # spiceUSBRedirection.enable = true;
    # qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  programs.virt-manager.enable = true;
    environment.shells = with pkgs; [ bash zsh ];
    environment.systemPackages = with pkgs;[
    git
    gh
    vscode
    (python312.withPackages(pypkgs: with pypkgs;[
    peewee
    tkinter
    pygame
    numpy
    pip
    jupyter
    pygobject3
    pydantic
    fastapi
    sqlalchemy
    uvicorn
    pyjwt
    python-multipart
    pynput
    pytest
    pytest-asyncio
    httpx
    pytest-mock
    pydantic-settings
    bcrypt
    asyncpg
    email-validator
    ]))
    ruff
    pkg-config
    portaudio
    zlib
    rustc
    cargo
    rust-analyzer
    cmake
    gcc
    libclang
    ffmpeg
    # beam27Packages.elixir
    nodejs_24
    bun
    # texliveFull
    pandoc
    typst
    # dbgate


    #SECTION: FUN

    cockatrice
    steam
    heroic
    cmatrix
    cbonsai
    rust-stakeholder
    hollywood
    genact
    neo
    # wineWowPackages.waylandFull
    # dxvk_2
    #shadps4

    #SECTION: DESKTOP

    (bottles.override {removeWarningPopup = true;})
    kiwix
    pinta
    kdePackages.okular
    audacity
    impression
    vlc
    libreoffice
    brave
    gimp-with-plugins
    krita
    inkscape-with-extensions
    obs-studio
    qimgv
    nautilus
    obsidian
    telegram-desktop
    bitwarden-desktop
    gnome-font-viewer
    anydesk
    nwg-look
    ghostty
    alacritty
    fuzzel
    openshot-qt
    gnome-disk-utility
    handbrake
    kdePackages.ark
    kdiff3
    losslesscut-bin
    strawberry
    vesktop
    # grayjay
    #CLI TOOLS
    micro-full
    cpulimit
    p7zip
    wget
    tlrc
    jq
    ijq
    fzf
    fd
    playerctl
    eza
    lm_sensors
    btop
    brightnessctl
    fastfetch
    clock-rs
    jp2a
    bat
    unrar
    rar
    ripgrep
    tree
    #WM
    alsa-utils
    hyprlock
    waybar
    rofi
    networkmanagerapplet
    bibata-cursors
    lyra-cursors
    phinger-cursors
    everforest-cursors
    gruvbox-plus-icons
    ];
    programs.niri = {
      enable = true;
      useNautilus = true;
      };
    services.displayManager.gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };
    # services.displayManager.cosmic-greeter.enable = true;

    services.gnome.gnome-keyring.enable = true;
    
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.nekoray = {
      enable = true;
      tunMode.enable = true;
      tunMode.setuid = false;
    };
    programs.yazi = {
      enable =true;
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
        SearchEngines = {
          Add = [
            {
              Name = "Brave Search";
              URLTemplate = "https://search.brave.com/search?q={searchTerms}";
              Method = "GET";
              IconURL = "https://cdn.search.brave.com/serp/v2/_app/immutable/assets/brave-search-icon.CsIFM2aN.svg";
              Alias = "@brave";
            }
          ];
          Default = "Brave Search";
          PreventInstalls = false;
        };
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

  #SECTION: THEME

#   stylix = {
#     enable = true;
#     base16Scheme = {
#       base00 = "#282828";
#       base01 = "#3c3836";
#       base02 = "#504945";
#       base03 = "#665c54";
#       base04 = "#928374";
#       base05 = "#ebdbb2";
#       base06 = "#fbf1c7";
#       base07 = "#f9f5d7";
#       base08 = "#cc241d";
#       base09 = "#d65d0e";
#       base0A = "#d79921";
#       base0B = "#98971a";
#       base0C = "#689d6a";
#       base0D = "#458588";
#       base0E = "#b16286";
#       base0F = "#9d0006";
#     };
#     cursor = {
#       package = pkgs.everforest-cursors;
#       name = "everforest-cursors";
#       size = 24;
#     };

#     # bibata-cursors
#     # lyra-cursors
#     # phinger-cursors
#     # everforest-cursors

#     fonts = {
#       monospace ={
#         package = pkgs.nerd-fonts.jetbrains-mono;
#         name = "JetBrainsMono Nerd Font Mono";
#       };
#     #   sansSerif = {
#     #     package = JetBrainsMono;
#     #     name = "JetBrainsMono Nerd Font";
#     #   };
#     #   serif = {
#     #     package = JetBrainsMono;
#     #     name = "JetBrainsMono Nerd Font";
#     #   };
#       emoji = {
#         package = pkgs.nerd-fonts.jetbrains-mono;
#         name = "JetBrainsMono Nerd Font Propo";
#       };
#       # sizes = {
#       #   applications = 12;
#       #   terminal = 15;
#       #   desktop = 10;
#       #   popups = 10;
#       # };
#     };
#     opacity = {
#       applications = 1.0;
#       desktop = 1.0;
#       popups = 1.0;
#       terminal = 0.70;
#     };
#     polarity = "dark";
#     targets = {
#       grub.enable = false;
#       plymouth.enable = false;
#       # firefox.profileNames = ["default"];
#       };
#     };
    distro-grub-themes = {
        enable = true;
        theme = "nixos";
    };
    # boot.plymouth = {
    #   enable = true;
    #   theme = "spinning-nekoarc";
    #   themePackages = with pkgs; [
    #       (pkgs.callPackage ../../modules/plymouth/spinning-nekoarc/spinning-nekoarc.nix {})
    #       (pkgs.callPackage ../../modules/plymouth/duck/duck.nix {})
    #   ];
    # };
    fonts = {
      packages = with pkgs; [
        dejavu_fonts
        nerd-fonts.jetbrains-mono
        vazir-fonts
        shabnam-fonts
      ];
      fontDir.enable = true;
  };

  #SECTION: SYSTEM

    networking.networkmanager.enable = true;
    services.tlp = {
        enable = true;
        pd.enable = true;
        setting = {
            STOP_CHARGE_THRESH_BAT0 = 1;
        };
    };
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
    boot= {
      kernelPackages = pkgs.linuxKernel.kernels.linux_zen;
      kernelParams = [
        "quiet"
        "splash"
      ];
      loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;
            timeout = 5;
            grub = {
                enable = true;
                efiSupport = true;
                useOSProber = true;
                device = "nodev";
            };
        };
    };
    programs.nh = {
      enable = true;
      clean= {
        enable = true;
        extraArgs = "--keep 5";
        dates = "weekly";
      };
      flake = "/etc/nixos/";
    };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
    ];
  };
  services.xserver.videoDrivers = [ "modesetting"];

}