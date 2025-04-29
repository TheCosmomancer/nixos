{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
    hyprpanel
    wireplumber
    libgtop
    networkmanagerapplet
    dart-sass
    wl-clipboard
    brightnessctl
    #bluez
    ];
}