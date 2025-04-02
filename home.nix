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


  programs.git = {
    enable = true;
    userName = "TheCosmomancer";
    userEmail = "lecosmomancer@gmail.com";
    aliases = {
      ch = "checkout";
      c = "commit -m";
      ca = "commit -am";
    };
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

  home.file = {
    ".config/alacritty/alacritty.toml".text = ''
    [general]
    import = [
    "~/.config/alacritty/theme.toml"
    ]
    '';
    ".config/hypr/startup.sh".text = ''
    hyprpanel&
    mpvpaper '*' /etc/nixos/media/spacecabin.mp4 -o "loop file"
    '';
    ".bashrc".text = ''
    fastfetch
    '';
    ".config/alacritty/theme.toml".text = ''
    # Default colors
    [colors.primary]
    background = '#1d2021'
    foreground = '#d4be98'

    # Normal colors
    [colors.normal]
    black   = '#32302f'
    red     = '#ea6962'
    green   = '#478ac3'
    yellow  = '#d8a657'
    blue    = '#7daea3'
    magenta = '#d3869b'
    cyan    = '#89b482'
    white   = '#d4be98'

    # Bright colors (same as normal colors)
    [colors.bright]
    black   = '#32302f'
    red     = '#ea6962'
    green   = '#478ac3'
    yellow  = '#d8a657'
    blue    = '#7daea3'
    magenta = '#d3869b'
    cyan    = '#89b482'
    white   = '#d4be98'

    [colors.selection]
    background = '#32302f'
    foreground = '#ba9d09'
    '';
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
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
