{ config, pkgs, lib, ... }:
{
  options = {
    dev.enable = 
      lib.mkEnableOption "enables dev";
  };
  config = lib.mkIf config.dev.enable {
    environment.systemPackages = with pkgs; [
    git
    gh
    vscodium
    python312Full
    texliveMedium
    ];
  };
}