{ config, pkgs, inputs, lib, ... }:
{
  options = {
    hypr.enable = 
      lib.mkEnableOption "enables hypr";
  };
  config = lib.mkIf config.hypr.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;};
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };
    environment.sessionVariables ={
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      # QT_QPA_PLATFORMTHEME = "qt5ct";
    };
    environment.systemPackages = with pkgs; [
    libnotify
    dunst
    wired
    hyprland-qtutils
    eww
    hyprlock
    rofi
    cosmic-launcher
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