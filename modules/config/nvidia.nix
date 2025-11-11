{ config, pkgs, lib, ... }:
{
  options = {
    nvidia.enable = 
      lib.mkEnableOption "enables nvidia";
  };
  config = lib.mkIf config.nvidia.enable {
    # NVIDIA:

      
  };
}