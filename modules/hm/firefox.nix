{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
            "browser.search.defaultenginename" = "ddg";
        };
    };
  };
}