{ config, inputs, pkgs, ... }:
{

# SECTION: VSCODE


  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        userSettings = {
            "files.autoSave" = "onFocusChange";
            "editor.formatOnPaste" = true;
            "security.workspace.trust.untrustedFiles" = "open";
            "telemetry.telemetryLevel" = "off";
            "python.analysis.typeCheckingMode" =  "standard";
            "chat.disableAIFeatures" = true;
            "task.allowAutomaticTasks" = "off";
            "extensions.ignoreRecommendations" = true;
            "C_Cpp.default.compilerPath" = "/run/current-system/sw/bin/g++";
            "python.testing.autoTestDiscoverOnSavePattern" = "*_test.py";
            "editor.fontFamily" = "'JetBrains Mono Nerd Font'";
            "workbench.productIconTheme" = "Tabler";
            "workbench.iconTheme" = "ayu";
            "workbench.colorTheme" = "GitHub Dark Default";
        };
        extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-python.vscode-pylance
        esbenp.prettier-vscode
        jgclark.vscode-todo-highlight
        james-yu.latex-workshop
        rust-lang.rust-analyzer
        ms-toolsai.jupyter
        supermaven.supermaven
        myriad-dreamin.tinymist
        antfu.slidev
        davidanson.vscode-markdownlint
        ms-vscode.cpptools
        zguolee.tabler-icons
        teabyii.ayu
        github.github-vscode-theme
        #TODO ADD TABOUT / kdl MANUALLY
        ];
    };
  };


# SECTION: ZSH
programs.zsh = { #TODO run p10k configure
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  autocd = true;
  plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    {
    name = "zsh-nix-shell";
    file = "nix-shell.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      owner = "chisui";
      repo = "zsh-nix-shell";
      rev = "v0.8.0";
      sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
    };
    }
    {
      name = "fzf-tab";
      src = pkgs.zsh-fzf-tab;
      file = "share/fzf-tab/fzf-tab.zsh";
    }
  ];
  initContent = "zstyle ':completion:*' completer _complete _ignored _correct _approximate\nzstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'\n[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh\ntypeset -g POWERLEVEL9K_INSTANT_PROMPT=off\nfastfetch";
  };

  home.shellAliases = {
    ls = "eza --git -F --color-scale --icons --group-directories-first";
    lsa = "eza --git -F -a --color-scale --icons --group-directories-first";
    vibegit = "git add -A && git commit -m \".\" && git push";
    pingg = "ping google.com";
    cat = "bat";
    # cp = "cpx"; #TODO enable after updating flake
  };



# SECTION: DOTFILES


    home.file = {
      
    ".config/ghostty/config".text = ''
    background-opacity = 0.85
    theme = dankcolors
    '';
    };
# SERCTION: HYPRLAND

# wayland.windowManager.hyprland = {

#   enable = true;
#   package = null;
#   portalPackage = null;
#   configType = "lua";
#   plugins =  [ pkgs.hyprlandPlugins.hyprbars ];
#   settings = {
#     monitor = {
#       _args = {
#         output   = "eDP-1";
#         mode     = "preferred";
#         position = "auto";
#         scale    = "auto";
#         mirror   = "HDMI-A-1";
#       };
#       _args = {
#         output   = "HDMI-A-1";
#         mode     = "preferred";
#         position = "auto";
#         scale    = "auto";
#       };
#     };
    
#   };
# };

}