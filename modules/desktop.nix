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
    qalculate-qt
    gimp-with-plugins
    obs-studio
    xreader
    nomacs
    bottles
    peazip
    file-roller
    obsidian
    nekoray
    thunderbird
    protonmail-desktop
    telegram-desktop
    bitwarden-desktop
    ];
  };
}