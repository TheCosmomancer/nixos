{ config, pkgs, lib, ... }:
{
  options = {
    nh.enable = 
      lib.mkEnableOption "enables nh"
  };
  config = lib.mkIf config.nh.enable {
      programs.nh = {
      enable = true;
      clean= {
        enable = true;
        extraArgs = "--keep 5";
        dates = "weekly";
      };
      flake = "/etc/nixos/";
    };
  };
}