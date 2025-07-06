{ config, lib, pkgs, ... }:
{
  imports = [
    ./bootloader.nix
    ./desktop.nix
    ./dev.nix
    ./fileman.nix
    ./firefox.nix
    ./fun.nix
    ./hypr.nix
    ./nh.nix
    ./nvidia.nix
    ./polkit.nix
    ./sddm.nix
    ./sysman.nix
    ./theme.nix
    ./virtualbox.nix
    ./laptop.nix
    ./plymouth.nix
  ];
  bootloader.enable = lib.mkDefault true;
  desktop.enable = lib.mkDefault true;
  dev.enable = lib.mkDefault true;
  fileman.enable = lib.mkDefault true;
  firefox.enable = lib.mkDefault true;
  fun.enable = lib.mkDefault false;
  hypr.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
  nvidia.enable = lib.mkDefault true;
  polkit.enable = lib.mkDefault true;
  sddm.enable = lib.mkDefault true;
  sysman.enable = lib.mkDefault true;
  theme.enable = lib.mkDefault true;
  virtualbox.enable = lib.mkDefault false;
  laptop.enable = lib.mkDefault false;
  plymouth.enable = lib.mkDefault true;
}