{ config, pkgs, lib, ... }:
{
  options = {
    bootloader.enable = 
      lib.mkEnableOption "enables bootloader";
  };
  config = lib.mkIf config.bootloader.enable {
    boot.loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;
            grub = {
                efiSupport = true;
                enable = true;
                useOSProber = true;
                device = "nodev";
            };
        };
    distro-grub-themes = {
        enable = true;
        theme = "nixos";
    };
  };
}