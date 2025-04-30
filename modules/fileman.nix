{ config, pkgs, lib, ... }:
{
  options = {
    fileman.enable = 
      lib.mkEnableOption "enables fileman"
  };
  config = lib.mkIf config.fileman.enable {
    programs.xfconf.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;
    programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
        thunar-media-tags-plugin
        thunar-archive-plugin
        thunar-volman
        ];
    };
    environment.systemPackages = with pkgs; [
        ranger
    ];
  };
}