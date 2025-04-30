{ config, pkgs, lib, ... }:
{
  options = {
    theme.enable = 
      lib.mkEnableOption "enables theme"
  };
  config = lib.mkIf config.theme.enable {
    environment.systemPackages = with pkgs; [
    fastfetch
    cmatrix
    cbonsai
    nwg-look
    libsForQt5.qt5ct
    dracula-icon-theme
    lavanda-gtk-theme
    bibata-cursors
    ];
  };
}