{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
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
    theme = "nixos";
  };
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tehran";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the hyprland.
 services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;

    theme = "sddm-astronaut-theme";
    extraPackages = [pkgs.sddm-astronaut];

    wayland.enable = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ir";
    variant = "";
    options = "grp:alt_shift_toggle,caps:super";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support and disable the lid closure switch for useage 
  # while connected to a montitor.
  services.libinput.enable = true;
  services.logind.lidSwitch = "ignore";
  services.logind.extraConfig = "HandleLidSwitch=ignore";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cosmomancer = {
    isNormalUser = true;
    description = "cosmomancer";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    nekoray
    telegram-desktop
    bitwarden-desktop
    cockatrice
    ];
  };

  security.sudo.extraRules = [
  {
    users = [ "cosmomancer" ];
    commands = [
      {
        command = "ALL";
        options = [ "SETENV" "NOPASSWD" ];
      }
    ];
  }
];


  home-manager = {
    extraSpecialArgs = {inherit inputs; };
    users = {
      "cosmomancer" = import ./home.nix;
    };

  backupFileExtension = "backup";
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #allow flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    #hyprland
    polkit_gnome
    hyprpaper
    ghostty
    rofi-wayland
    hyprland-qtutils
    waybar
    #hyprpanel
    hyprpanel
    wireplumber
    libgtop
    networkmanagerapplet
    dart-sass
    wl-clipboard
    brightnessctl
    #apps
    lm_sensors
    git
    gh
    vlc
    brave
    librewolf
    vscode
    libreoffice
    qalculate-qt
    gimp-with-plugins
    obs-studio
    xreader
    nomacs
    bottles
    peazip
    file-roller
    grimblast
    btop
    ventoy-full-gtk
    obsidian
    python312Full
    ranger
    #fun & flair
    fastfetch
    cmatrix
    cbonsai
    nwg-look
    libsForQt5.qt5ct
    dracula-icon-theme
    lavanda-gtk-theme
    bibata-cursors
    libsForQt5.qt5.qtquickcontrols2
    sddm-sugar-dark
    sddm-astronaut
    #nerd-fonts.jetbrains-mono MAKE SURE to manually install
  ]; # TODO firefox home-manager

  # Polkit
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

  programs.zsh.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;
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
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "cosmomancer" ];
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.addNetworkInterface = false;

  environment.sessionVariables ={
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Enable fail2ban 
  services.fail2ban.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #just don't change this and you'll be fine
  system.stateVersion = "24.11";

  # NVIDIA:

  # Install nvidia drivers
  hardware.graphics = {
    enable = true;
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
    powerManagement.finegrained = true;

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
    };
    hardware.nvidia.prime = {
      reverseSync.enable = true;
      # Enable if using an external GPU
      allowExternalGpu = false;
      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:1:0";
      nvidiaBusId = "PCI:0:6:0";
      # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
	};
  hardware.graphics.enable32Bit = true;
}
