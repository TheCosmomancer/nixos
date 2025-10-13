{ config, pkgs, lib, ... }:
{
  options = {
    desktop.enable = 
      lib.mkEnableOption "enables desktop";
  };
  config = lib.mkIf config.desktop.enable {
    #DESKTOP APPS
    environment.systemPackages = with pkgs; [
    celluloid
    libreoffice
    brave
    gimp-with-plugins
    inkscape-with-extensions
    obs-studio
    xreader
    nomacs
    xarchiver
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
    virt-manager
    mission-center
    # protonvpn-gui
    # v2ray
    # nekoray
    # v2rayn
    # hiddify-app
    libsForQt5.kdenlive
    shotcut
    #CLI TOOLS
    difftastic/*  */
    tlrc
    jq
    ijq
    fzf
    fd
    playerctl
    mpc
    up
    eza
    lm_sensors
    btop
    networkmanagerapplet
    brightnessctl
    fastfetch
    jp2a
    browsh
    bat
    ripgrep
    alsa-utils
    # bluez
    ];
    programs.nekoray = {
      enable = true;
      tunMode.enable = true;
      tunMode.setuid = false;
    };
    # services.v2raya.enable = true;
    # systemd.services.v2raya.serviceConfig = {
    #   AmbientCapabilities = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" "CAP_NET_RAW" ];
    #   CapabilityBoundingSet = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" "CAP_NET_RAW" ];
    # };
    # boot.kernel.sysctl = {
    #   "net.ipv4.ip_forward" = 1;
    #   "net.ipv6.conf.all.fowrading" = 1;
    # };
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
  };
}