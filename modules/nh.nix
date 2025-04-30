{ config, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5";
    flake = "/etc/nixos/flake.nix";
  };
}