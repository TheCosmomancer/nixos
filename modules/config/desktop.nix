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
    virt-manager
    mission-center
    shotcut
    audio-recorder
    localsend
    gnome-disk-utility
    copyq
    geeqie
    #CLI TOOLS
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
    alsa-utils
    # bluez
    ];
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      # enableZshIntegration = true;
    };
    programs.direnv = {
      enable = true;
      enableFishIntegration = true;
      # enableZshIntegration = true;
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
  };
}
