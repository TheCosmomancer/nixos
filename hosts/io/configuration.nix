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
    extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
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

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    environmentVariables = {
      "GGML_VK_DISABLE_F16" = "1";
    };
  };
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
    (python314.withPackages(pypkgs: with pypkgs;[
    pillow
    cairosvg
    colorama
    marko
    requests
    scrapy
    beautifulsoup4
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
    dbus-python
    ]))
    uv
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
    lutris
    heroic
    # bottles #TODO
    dxvk_2
    cmatrix
    cbonsai
    rust-stakeholder
    hollywood
    genact
    neo
    toilet
    # wineWowPackages.waylandFull
    #shadps4

    #SECTION: DESKTOP
    
    davinci-resolve
    kiwix
    pinta
    kdePackages.okular
    audacity
    impression
    vlc
    libreoffice
    onlyoffice-desktopeditors
    gimp-with-plugins
    krita
    localsend
    inkscape-with-extensions
    obs-studio
    qimgv
    kdePackages.dolphin
    libmtp
    kdePackages.kio-extras
    obsidian
    telegram-desktop
    bitwarden-cli #TODO swap back to bitwarden-desktop (electron marked unsafe)
    gnome-font-viewer
    anydesk
    nwg-look
    ghostty
    foliate
    blender
    shotcut
    gnome-calculator
    gnome-disk-utility
    # handbrake #TODO
    kdePackages.ark
    meld
    losslesscut-bin
    strawberry
    picard
    vesktop
    firefox
    brave
    chromium
    packet
    # grayjay
    #CLI TOOLS
    micro-full
    # cpx #TODO enable after updating flake
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
    busybox
    jp2a
    bat
    unrar
    rar
    ripgrep
    tree
    xeyes
    #WM
    grim
    hyprpolkitagent
    alsa-utils
    libsForQt5.qt5ct
    kdePackages.qt6ct
    bibata-cursors
    gruvbox-plus-icons
    ];
    services.gvfs.enable = true;
    services.udisks2.enable = true;
    services.tumbler.enable = true;
    services.udev.enable = true;
    programs.niri.enable = true;
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    programs.dms-shell = {
    	enable = true;
    	systemd = {
    		enable = true;
    		restartIfChanged = true;
    	};
    };
    programs.dsearch = {
      enable = true;
      systemd = {
        enable = true;
      };
    };
    services.displayManager.dms-greeter = {
      enable = true;
      configHome = "/home/cosmomancer";
      compositor.name = "hyprland";
    };
    qt = {
      enable = true;
      platformTheme = "qt5ct";
    };

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    security.polkit.enable = true;
    # security.soteria.enable = true;
    
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    # programs.pay-respects.enable = true; #TODO check on for zsh interigation
    programs.throne = {
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

    distro-grub-themes = {
        enable = true;
        theme = "lenovo";
    };
    boot.plymouth = {
      enable = true;
      theme = "bgrt";
    };
    fonts = {
      packages = with pkgs; [
        dejavu_fonts
        nerd-fonts.jetbrains-mono
        vazirmatn
        shabnam-fonts
      ];
      fontDir.enable = true;
  };

  #SECTION: SYSTEM

    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
    };
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = false;
    services.upower.enable = true;
    services.tlp = {
    	enable = true;
    	pd.enable = true;
    	settings = {
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
      kernelPackages = pkgs.linuxPackages_latest;
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        # "xe.force_probe=7dd1"
        # "i915.force_probe=!7dd1"
      ];
      # extraModprobeConfig = ''
      #   options xe enable_dsb=0 enable_dc=0
      # '';
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
    package = pkgs.mesa;
    extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
    ];
  };
  services.xserver.videoDrivers = [ "modesetting" ];

}
