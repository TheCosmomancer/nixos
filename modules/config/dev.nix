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
    vscode
    vim
    python313Full
    texliveFull
    sqlitebrowser
    proxychains
    fzf
    uv
    ];
  };
}