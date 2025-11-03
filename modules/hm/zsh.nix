{ config, pkgs, lib, ... }:
{
# programs.zsh = {
  
#   enable = true;
#   enableCompletion = true;
#   autosuggestion.enable = true;
#   syntaxHighlighting.enable = true;
#   autocd = true;
#   plugins = [
#     {
#       name = "powerlevel10k";
#       src = pkgs.zsh-powerlevel10k;
#       file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
#     }
#     {
#     name = "zsh-nix-shell";
#     file = "nix-shell.plugin.zsh";
#     src = pkgs.fetchFromGitHub {
#       owner = "chisui";
#       repo = "zsh-nix-shell";
#       rev = "v0.8.0";
#       sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
#     };
#     }
#   ];
#   initContent = "zstyle ':completion:*' completer _complete _ignored _correct _approximate\nzstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'\n[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh\ntypeset -g POWERLEVEL9K_INSTANT_PROMPT=off\nfastfetch";
#   };
#   home.shellAliases = {
#     mkcd = "mkdir -p \"$1\" && cd \"$1\"";
#     ll = "eza --git -F --color-scale --icons --group-directories-first";
#     lla = "eza --git -F -a --color-scale --icons --group-directories-first";
#   };
}