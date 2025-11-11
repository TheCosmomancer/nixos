{ config, pkgs, lib, ... }:
{
  options = {
    desktop.enable = 
      lib.mkEnableOption "enables desktop";
  };
  config = lib.mkIf config.desktop.enable {
    #DESKTOP APPS
    environment.systemPackages = with pkgs; [
    
    ];
  };
}
