{ config, pkgs, inputs, lib, ... }:
{
  options = {
    hypr.enable = lib.mkEnableOption "enables hypr";
  };
  
  config = lib.mkIf config.hypr.enable {
    
  };
}