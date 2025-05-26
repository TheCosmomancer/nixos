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
            "browser.search.defaultenginename" = "brave";
        };
        search = {
           force = true;
           default = "brave";
        
           engines = {
        
             "brave" = {
               urls = [
                 {
                   template = "https://search.brave.com/search?";
                   params = [
                     {
                       name = "q";
                       value = "{searchTerms}";
                     }
                   ];
                 }
               ];
             };
        }; 
     };
    };
  };
}