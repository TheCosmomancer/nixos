{ config, pkgs, lib, ... }:
{
  options = {
    fun.enable = 
      lib.mkEnableOption "enables fun";
  };
  config = lib.mkIf config.fun.enable {
    environment.systemPackages = with pkgs; [
        cockatrice
        lutris
        wineWowPackages.waylandFull
        dxvk_2
        steam
        mommy
        cmatrix
        cbonsai
        fastfetch
        neo
        #shadps4
        ];
  };
}