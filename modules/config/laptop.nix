{ config, pkgs, lib, ... }:
{
  options = {
    laptop.enable = 
      laptop.mkEnableOption "enables lid";
  };
  config = laptop.mkIf config.lid.enable {
    services.libinput.enable = true;
    services.logind.lidSwitch = "ignore";
    services.logind.extraConfig = "HandleLidSwitch=ignore";
  };
}