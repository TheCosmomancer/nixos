{ config, pkgs, ... }:
{
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
    ".local/share/rofi/themes/rounded-gray-dark.rasi".text = ''
    * {
    bg0:    #212121F2;
    bg1:    #2A2A2A;
    bg2:    #3D3D3D80;
    bg3:    #616161F2;
    fg0:    #E6E6E6;
    fg1:    #FFFFFF;
    fg2:    #969696;
    fg3:    #3D3D3D;
}

    @import "rounded-common.rasi"

    element selected {
        text-color: @bg1;
    }
    '';
    ".config/fastfetch/config.jsonc".text = ''
    //   _____ _____ _____ _____ _____ _____ _____ _____ _____ 
    //  |   __|  _  |   __|_   _|   __|   __|_   _|     |  |  |
    //  |   __|     |__   | | | |   __|   __| | | |   --|     |
    //  |__|  |__|__|_____| |_| |__|  |_____| |_| |_____|__|__|  HYPRLAND
    //
    //  by Bina


    {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "logo": {
            "source": "/etc/nixos/media/nix-grid.webp",
            "type": "kitty",
            "height": 8,
            "padding": {
                "top": 1
            }
        },
        "display": {
            "separator": " "
        },
        "modules": [
        "break",
        {
            "type": "title",
            "keyWidth": 10
        },
            "break",
        {
            "type": "os",
            "format": "{2}",
            "key": " ",
            "keyColor": "38;5;153",  // = color4
        },
        {
            "type": "kernel",
            "key": " ",
            "keyColor": "38;5;69",
        },
        {
            "type": "packages",
            "format": "{} (nixpkgs)",
            "key": " ",
            "keyColor": "38;5;153",  
        },
        {
            "type": "wm",
            "format": "{1}",
            "key": " ",
            "keyColor": "38;5;69", 
        },
        {
            "type": "shell",
            "format": "{1}",
            "key": " ",
            "keyColor": "38;5;153", 
        },
        {
            "type": "terminal",
            "format": "{1}",
            "key": " ",
            "keyColor": "38;5;69", 
        },
        "break"
        ]
    }
    '';
  };
}