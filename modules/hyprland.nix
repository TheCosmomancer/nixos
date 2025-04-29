{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
    polkit_gnome
    hyprpaper
    ghostty
    rofi-wayland
    hyprland-qtutils
    waybar
    ];
}