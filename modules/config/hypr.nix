{ config, pkgs, lib, ... }:
{
  options = {
    hypr.enable = 
      lib.mkEnableOption "enables hypr";
  };
  config = lib.mkIf config.hypr.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    environment.sessionVariables ={
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      # QT_QPA_PLATFORMTHEME = "qt5ct";
    };
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    };
    environment.systemPackages = with pkgs; [
    libnotify
    dunst
    wired
    hyprpaper
    hyprland-qtutils
    eww
    hyprlock
    rofi-wayland
    hyprshot
    polkit_gnome
    #hyprpolkitagent
    # hyprpanel
    # alsa-utils
    # wireplumber
    # libgtop
    # dart-sass
    # wl-clipboard
    # bluez
    ];
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
  };
}