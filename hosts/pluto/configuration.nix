{ config, pkgs, inputs, ... }:

{

  # SECTION: BASE

  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "pluto";
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
    useGlobalPkgs = true;
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
        home.stateVersion = "24.11";
      };
    };
  };
  #just don't change this and you'll be fine
  system.stateVersion = "24.11";

  #SECTION: DEVELOPMENT

  programs.nixvim = {
  enable = true;
  };
  virtualisation = {
    libvirtd.enable = true;
    # spiceUSBRedirection.enable = true;
    # qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  # environment.sessionVariables = {
    #   LD_LIBRARY_PATH = ["${pkgs.gcc.cc.lib}/lib"];};
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
    faster-whisper
    pyaudio
    ]))
    ruff
    python312Packages.xonsh
    gcc
    pkg-config
    portaudio
    zlib
    rustc
    cargo
    rust-analyzer
    cmake
    libclang
    ffmpeg
    beam27Packages.elixir
    # texliveFull
    # pandoc
    typst
    dbgate
    virt-manager
    bash


    #SECTION: FUN

    cockatrice
    wineWowPackages.waylandFull
    dxvk_2
    steam
    lutris
    cmatrix
    cbonsai
    rust-stakeholder
    hollywood
    genact
    neo
    lolcat
    cowsay
    #shadps4

    #SECTION: DESKTOP

    vlc
    libreoffice
    brave
    gimp-with-plugins
    inkscape-with-extensions
    obs-studio
    xreader
    nomacs
    obsidian
    telegram-desktop
    bitwarden-desktop
    gnome-font-viewer
    rustdesk
    nwg-look
    ghostty
    kitty
    virt-manager
    mission-center
    shotcut
    audio-recorder
    localsend
    gnome-disk-utility
    handbrake
    copyq
    geeqie
    strawberry
    #CLI TOOLS
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
    ripgrep
    #HYPRLAND
    alsa-utils
    hyprland-qtutils
    eww
    hyprlock
    rofi
    hyprshot
    polkit_gnome
    networkmanagerapplet
    #hyprpolkitagent
    # hyprpanel
    # alsa-utils
    # wireplumber
    # libgtop
    # dart-sass
    # wl-clipboard
    # bluez
    bibata-cursors
    gruvbox-plus-icons
    ];
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      };
    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    
    services.gnome.gnome-keyring.enable = true;
    
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    services.lorri.enable = true;
    
    programs.nekoray = {
      enable = true;
      tunMode.enable = true;
      tunMode.setuid = false;
    }; # get configs at https://github.com/barry-far/V2ray-Config
    services.cloudflare-warp.enable = true;
    programs.yazi = {
      enable =true;
    };
    programs.xfconf.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
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

  #SECTION: THEME

  stylix = {
    enable =true;
    base16Scheme = {
      base00 = "#282828";
      base01 = "#3c3836";
      base02 = "#504945";
      base03 = "#665c54";
      base04 = "#928374";
      base05 = "#ebdbb2";
      base06 = "#fbf1c7";
      base07 = "#f9f5d7";
      base08 = "#cc241d";
      base09 = "#d65d0e";
      base0A = "#d79921";
      base0B = "#98971a";
      base0C = "#689d6a";
      base0D = "#458588";
      base0E = "#b16286";
      base0F = "#9d0006";
    };
    # cursor = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Classic";
    # };
    # fonts = {
    #   monospace ={
    #     package = JetBrainsMono;
    #     name = "JetBrainsMono Nerd Font Mono";
    #   };
    #   sansSerif = {
    #     package = JetBrainsMono;
    #     name = "JetBrainsMono Nerd Font";
    #   };
    #   serif = {
    #     package = JetBrainsMono;
    #     name = "JetBrainsMono Nerd Font";
    #   };
    # };
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.7;
    };
    polarity = "dark";
    targets = {
      grub.enable = false;
      plymouth.enable = false;
      # firefox.profileNames = ["default"];
      };
    };
    distro-grub-themes = {
        enable = true;
        theme = "nixos";
    };
    boot.plymouth = {
      enable = true;
      theme = "deus_ex";
      themePackages = with pkgs; [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
          selected_themes = [ "deus_ex" ];
          })
      ];
    };
    fonts = {
      packages = with pkgs; [
        dejavu_fonts
        nerd-fonts.jetbrains-mono
        noto-fonts-monochrome-emoji
        vazir-fonts
        shabnam-fonts
      ];
    
      # fontconfig = {
      #   enable = true;
      #   defaultFonts = {
      #     serif = [ "DejaVu Serif" ];
      #     sansSerif = [ "DejaVu Sans" ];
      #     monospace = [ "JetBrains Mono Nerd Font" ];
      #     emoji = [ "Noto Emoji" ];
      #     # emoji = [ "Beedii" "Noto Emoji" ];
      #   };
      # };
      # Enable font discovery for applications
      fontDir.enable = true;
  };

  #SECTION: SYSTEM

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
    nix.settings = {
      max-jobs = 1;
      cores = 2;
      keep-going = false;
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
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
      loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;
            timeout = 5;
            grub = {
                efiSupport = true;
                enable = true;
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


  #SECTION: NVIDIA

  # Install nvidia drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;  # Provides nvidia-offload command
      };
      amdgpuBusId = "PCI:6:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
