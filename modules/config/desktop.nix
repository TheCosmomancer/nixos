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
    obsidian
    v2rayn
    persepolis
    telegram-desktop
    discord
    bitwarden-desktop
    ];
    services.cloudflare-warp.enable = true;
  };
}