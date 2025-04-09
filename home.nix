{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cosmomancer";
  home.homeDirectory = "/home/cosmomancer";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  programs.zsh = {
  
  enable = true;
  initExtraFirst = "zstyle ':completion:*' completer _complete _ignored _correct _approximate\nzstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'";
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
  ];
  shellAliases = {
      update = "sudo nixos-rebuild switch --flake /etc/nixos#cosmomancer";
      flakeupdate = "sudo nix flake update";
      CD = "echo 'C DEEZ NUTS'";
  };
  initExtra = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh\ntypeset -g POWERLEVEL9K_INSTANT_PROMPT=off\nfastfetch";
};

  #xdg.mimeApps.defaultApplications = {};
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".local/share/rofi/themes/rounded-common.rasi".text = ''
    * {
        font:   "Roboto 12";

        background-color:   transparent;
        text-color:         @fg0;

        margin:     0px;
        padding:    0px;
        spacing:    0px;
    }

    window {
        location:       north;
        y-offset:       calc(50% - 176px);
        width:          480;
        border-radius:  24px;

        background-color:   @bg0;
    }

    mainbox {
        padding:    12px;
    }

    inputbar {
        background-color:   @bg1;
        border-color:       @bg3;

        border:         2px;
        border-radius:  16px;

        padding:    8px 16px;
        spacing:    8px;
        children:   [ prompt, entry ];
    }

    prompt {
        text-color: @fg2;
    }

    entry {
        placeholder:        "Search";
        placeholder-color:  @fg3;
    }

    message {
        margin:             12px 0 0;
        border-radius:      16px;
        border-color:       @bg2;
        background-color:   @bg2;
    }

    textbox {
        padding:    8px 24px;
    }

    listview {
        background-color:   transparent;

        margin:     12px 0 0;
        lines:      8;
        columns:    1;

        fixed-height: false;
    }

    element {
        padding:        8px 16px;
        spacing:        8px;
        border-radius:  16px;
    }

    element normal active {
        text-color: @bg3;
    }

    element alternate active {
        text-color: @bg3;
    }

    element selected normal, element selected active {
        background-color:   @bg3;
    }

    element-icon {
        size:           1em;
        vertical-align: 0.5;
    }

    element-text {
        text-color: inherit;
    }
    '';
    ".local/share/rofi/themes/rounded-nord-dark.rasi".text = ''
    * {
    bg0:    #2E3440F2;
    bg1:    #3B4252;
    bg2:    #4C566A80;
    bg3:    #88C0D0F2;
    fg0:    #D8DEE9;
    fg1:    #ECEFF4;
    fg2:    #D8DEE9;
    fg3:    #4C566A;
    }

    @import "rounded-common.rasi"

    element selected {
        text-color: @bg1;
    }
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cosmomancer/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
