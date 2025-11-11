{ config, pkgs, lib, ... }:
{
  options = {
    theme.enable = 
      lib.mkEnableOption "enables theme";
  };
  config = lib.mkIf config.theme.enable {
    environment.systemPackages = with pkgs; [
    ];

  };
}