{ config, lib, pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./dev.nix
    ./hypr.nix
    ./laptop.nix
    ./nvidia.nix
    ./system.nix
    ./theme.nix
    ./fun.nix
  ];
  desktop.enable = lib.mkDefault true;
  dev.enable = lib.mkDefault true;
  hypr.enable = lib.mkDefault false;
  nvidia.enable = lib.mkDefault false;
  laptop.enable = lib.mkDefault false;
  system.enable = lib.mkDefault true;
  theme.enable = lib.mkDefault false;
  fun.enable = lib.mkDefault false;
}