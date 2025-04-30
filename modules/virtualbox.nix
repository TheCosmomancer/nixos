{ config, pkgs, lib, ... }:
{
  options = {
    virtualbox.enable = 
      lib.mkEnableOption "enables virtualbox"
  };
  config = lib.mkIf config.virtualbox.enable {
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableKvm = true;
    virtualisation.virtualbox.host.addNetworkInterface = false;
  };
}