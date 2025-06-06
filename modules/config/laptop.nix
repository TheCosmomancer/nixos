{ config, pkgs, lib, ... }:
{
  options = {
    laptop.enable = 
      lib.mkEnableOption "enables lid";
  };
  config = lib.mkIf config.laptop.enable {
    services.libinput.enable = true;
    services.logind.lidSwitch = "ignore";
    services.logind.extraConfig = "HandleLidSwitch=ignore";
  };
}