{ config, lib, pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./dev.nix
    ./hypr.nix
    ./laptop.nix
    ./nvidia.nix
  ];
  desktop.enable = lib.mkDefault true;
  dev.enable = lib.mkDefault true;
  hypr.enable = lib.mkDefault true;
  nvidia.enable = lib.mkDefault false;
  laptop.enable = lib.mkDefault false;
}