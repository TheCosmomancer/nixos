{ config, pkgs, lib, ... }:
{
  options = {
    sddm.enable = 
      lib.mkEnableOption "enables sddm";
  };
  config = lib.mkIf config.sddm.enable {
      services.displayManager.sddm = {
        enable = true;
        package = pkgs.libsForQt5.sddm;
        wayland.enable = true;
        sugarCandyNix = {
          enable = true;
          settings = {
            Background = /etc/nixos/media/astronautgarden.png;
            ScreenWidth = 1920;
            ScreenHeight = 1080;
            FormPosition = "left";
            MainColor = "white";
            AccentColor = "black";
            # OverrideLoginButtonTextColor = "";
            HeaderText = "";
            DateFormat = "dddd, MMMM d, yyyy";
          };
        };
      };
    services.xserver.displayManager.setupCommands = "xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-1 --same-as eDP-1";
  };
}