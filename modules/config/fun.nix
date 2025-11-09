{ config, pkgs, lib, ... }:
{
  options = {
    fun.enable = 
      lib.mkEnableOption "enables fun";
  };
  config = lib.mkIf config.fun.enable {
    environment.systemPackages = with pkgs; [
        cockatrice
        wineWowPackages.waylandFull
        dxvk_2
        steam
        lutris
        cmatrix
        cbonsai
        rust-stakeholder
        hollywood
        genact
        neo
        lolcat
        cowsay
        #shadps4
        ];
        
  };
}