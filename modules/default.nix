{ config, pkgs, ... }:
{
    imports =
    [
      ./virtualbox.nix
      ./thunar.nix
      ./sddm.nix
      ./polkit.nix
      ./nvidia.nix
      ./hyprpanel.nix
      ./hyprland.nix
      ./firefox.nix
    ];
}