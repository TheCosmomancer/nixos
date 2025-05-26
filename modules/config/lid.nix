{ config, pkgs, lib, ... }:
{
  options = {
    lid.enable = 
      lib.mkEnableOption "enables lid";
  };
  config = lib.mkIf config.lid.enable {
    services.logind.lidSwitch = "ignore";
    services.logind.extraConfig = "HandleLidSwitch=ignore";
  };
}