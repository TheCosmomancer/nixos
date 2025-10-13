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
    ".config/hypr/hyprlock.conf".text = ''
    general{
    hide_cursor = true
    ignore_empty_input = true
    }
    background {
        monitor =
        path = screenshot
        blur_passes = 1
        blur_size = 4
        brightness = 0.9
        contrast = 0.9
    }

    input-field {
        monitor =
        size = 200, 60
        outline_thickness = 0
        dots_size = 0.25
        dots_spacing = 0.35
        dots_center = true
        outer_color = rgba(0, 0, 0, 0.5)
        inner_color = rgba(255, 255, 255, 0.1)
        font_color = rgba(255, 255, 255,0.5)
        fade_on_empty = true
        placeholder_text = 
        hide_input = false
        position = 0, -200
        halign = center
        valign = center
    }
    '';
    ".config/rofi/config.rasi".text = ''
    configuration {
        show-icons: true;
        font: "JetBrains Mono 12";

        display-ssh:    "󰣀 ssh:";
        display-run:    "󱓞 run:";
        display-drun:   "󰣖 drun:";
        display-window: "󱂬 window:";
        display-combi:  "󰕘 combi:";
        display-filebrowser: "󰉋 filebrowser:";

        dpi: 120;
    }

    @theme "gruvbox-material"
    '';
    ".config/rofi/themes/gruvbox-material.rasi".text = ''
    * {
        bg0: #282828;
        bg1: #32302f;
        grey0: #7c6f64;
        fg0: #d4be98;

        blue: #7daea3;
        red: #ea6962;
        orange: #e78a4e;
        green: #a9b665;
        bgStatusline3: #504945;

        background-color: @bg0;
    }

    window {
        height: 600;
        width: 600;

        border: 1;
        border-radius: 10;
        border-color: @bgStatusline3;
    }

    mainbox {
        spacing: 0;
        children: [inputbar, message, listview];
    }

    inputbar {
        color: @fg0;
        padding: 14;
        background-color: @bg0;
    }

    message {
        padding: 10;
        background-color: @grey0;
    }

    listview {
        padding: 8;
        border-radius: 0 0 10 10;
        border: 2 2 2 2;
        border-color: @bg0;
        background-color: @bg0;
        dynamic: false;
    }

    textbox {
        text-color: @fg0;
        background-color: inherit;
    }

    error-message {
        border: 20 20 20 20;
    }

    entry, prompt, case-indicator {
        text-color: inherit;
    }

    prompt {
        margin: 0 10 0 0;
    }

    element {
        padding: 5;
        vertical-align: 0.5;
        border-radius: 10;
        background-color: @bg1;
    }

    element.selected.normal {
        background-color: @grey0;
    }

    element.alternate.normal {
        background-color: inherit;
    }

    element.normal.active, element.alternate.active {
        background-color: @orange;
    }

    element.selected.active {
        background-color: @green;
    }

    element.normal.urgent, element.alternate.urgent {
        background-color: @red;
    }

    element.selected.urgent {
        background-color: @blue;
    }

    element-text, element-icon {
        size: 40;
        margin: 0 10 0 0;
        vertical-align: 0.5;
        background-color: inherit;
        text-color: @fg0;
    }

    element-text .active, element-text .urgent {
        text-color: @bg0;
    }
    '';
    ".config/rofi/themes/rounded-gray.rasi".text = ''
    {
        font:   "Roboto 12";

        background-color:   transparent;
        text-color:         @fg0;

        margin:     0px;
        padding:    0px;
        spacing:    0px;

        bg0:    #212121F2;
        bg1:    #2A2A2A;
        bg2:    #3D3D3D80;
        bg3:    #616161F2;
        fg0:    #E6E6E6;
        fg1:    #FFFFFF;
        fg2:    #969696;
        fg3:    #3D3D3D;
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