{ config, pkgs, lib, ... }:
{
  options = {
    system.enable = 
      lib.mkEnableOption "enables system";
  };
  config = lib.mkIf config.system.enable {
    
  };
}
