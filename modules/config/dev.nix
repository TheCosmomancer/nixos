{ config, pkgs, lib, ... }:
{
  options = {
    dev.enable = 
      lib.mkEnableOption "enables dev";
  };
  config = lib.mkIf config.dev.enable {
    environment.systemPackages = with pkgs; [
    git
    gh
    vscodium
    vim
    python312Full
    texliveMedium
    sqlitebrowser
    proxychains
    zoxide
    fzf
    ];
  };
}