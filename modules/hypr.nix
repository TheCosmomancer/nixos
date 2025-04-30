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
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    };
    environment.systemPackages = with pkgs; [
        hyprpaper
        ghostty
        rofi-wayland
        hyprland-qtutils
        hyprpanel
        grimblast
    ];
  };
}