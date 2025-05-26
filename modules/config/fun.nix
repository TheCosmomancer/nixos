{ config, pkgs, lib, ... }:
{
  options = {
    fun.enable = 
      lib.mkEnableOption "enables fun";
  };
  config = lib.mkIf config.fun.enable {
    environment.systemPackages = with pkgs; [
    cockatrice
    mommy
    #shadps4
    ];
  };
}