{ config, pkgs, lib, ... }:
{
    imports = [
        ./dotfiles.nix
        ./hypr.nix
        ./vsc.nix
        ./zsh.nix
    ];
}