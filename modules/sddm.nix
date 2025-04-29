{ config, pkgs, ... }:
{
    services.displayManager.sddm = {
    package = pkgs.libsForQt5.sddm;
    wayland.enable = true;
    sugarCandyNix = {
      enable = true;
      settings = {
        Background = /etc/nixos/media/castle.png;
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        FormPosition = "left";
      };
    };
  };
  services.xserver.displayManager.setupCommands = "xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-1 --same-as eDP-1";
}