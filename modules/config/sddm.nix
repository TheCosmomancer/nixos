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
      autoNumlock = true;
      # setupScript = "wlr-randr --output eDP-1 --mode 1920x1080 --pos 0,0 --output HDMI-A-1 --mode 1920x1080 --pos 0,0";
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
    environment.systemPackages = with pkgs; [kanshi];
    # services.xserver.displayManager.setupCommands = "wlr-randr --output eDP-1 --mode 1920x1080 --pos 0,
  };
}