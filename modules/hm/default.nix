{ config, pkgs, lib, ... }:
{
    imports = [
        ./dotfiles.nix
        ./firefox.nix
        ./hypr.nix
        ./vsc.nix
        ./zsh.nix
    ];
}