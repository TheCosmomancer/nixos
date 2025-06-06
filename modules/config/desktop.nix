{ config, pkgs, lib, ... }:
{
  options = {
    desktop.enable = 
      lib.mkEnableOption "enables desktop";
  };
  config = lib.mkIf config.desktop.enable {
    environment.systemPackages = with pkgs; [
    vlc
    libreoffice
    gimp-with-plugins
    obs-studio
    xreader
    nomacs
    peazip
    file-roller
    obsidian
    nekoray
    persepolis
    telegram-desktop
    bitwarden-desktop
    ];
  };
}