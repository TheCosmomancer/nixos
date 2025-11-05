{ config, pkgs, inputs, lib, ... }:
{
  options = {
    hypr.enable = lib.mkEnableOption "enables hypr";
  };
  
  config = lib.mkIf config.hypr.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
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