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
    lutris
    bottles
    wineWowPackages.waylandFull
    dxvk_2
    steam
    #shadps4
    ];
  };
}