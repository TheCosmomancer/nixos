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
        display-drun:   "󰣖 drun:";
        dpi: 120;
    }

    @theme "cooltheme"
    '';
    ".config/rofi/themes/cooltheme.rasi".text = ''
    /*****----- Configuration -----*****/
    configuration {
        modi:                       "drun";
        show-icons:                 true;
        display-drun:               "";
        drun-display-format:        "{name}";
    }

    /*****----- Global Properties -----*****/
    * {
        font:                        "JetBrains Mono Nerd Font 10";
        background:                  #231419;
        background-alt:              #2D1E23;
        foreground:                  #FFFFFF;
        selected:                    #426647;
        active:                      #2E3F34;
        urgent:                      #D08261;
    }

    /*****----- Main Window -----*****/
    window {
        /* properties for window widget */
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       600px;
        x-offset:                    0px;
        y-offset:                    0px;

        /* properties for all widgets */
        enabled:                     true;
        border-radius:               20px;
        cursor:                      "default";
        background-color:            @background;
    }

    /*****----- Main Box -----*****/
    mainbox {
        enabled:                     true;
        spacing:                     0px;
        background-color:            transparent;
        orientation:                 vertical;
        children:                    [ "inputbar", "listbox" ];
    }

    listbox {
        spacing:                     20px;
        padding:                     20px;
        background-color:            transparent;
        orientation:                 vertical;
        children:                    [ "message", "listview" ];
    }

    /*****----- Inputbar -----*****/
    inputbar {
        enabled:                     true;
        spacing:                     10px;
        padding:                     80px 60px;
        background-color:            transparent;
        background-image:            url("/etc/nixos/media/nightcabingirlrofi.png", width);
        text-color:                  @foreground;
        orientation:                 horizontal;
        children:                    [ "textbox-prompt-colon", "entry", "dummy" ];
    }
    textbox-prompt-colon {
        enabled:                     true;
        expand:                      false;
        str:                         "";
        padding:                     12px 15px;
        border-radius:               100%;
        background-color:            @background-alt;
        text-color:                  inherit;
    }
    entry {
        enabled:                     true;
        expand:                      false;
        width:                       420px;
        padding:                     12px 16px;
        border-radius:               100%;
        background-color:            @background-alt;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "Search";
        placeholder-color:           inherit;
    }
    dummy {
        expand:                      true;
        background-color:            transparent;
    }

    /*****----- Listview -----*****/
    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       7;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
        
        spacing:                     10px;
        background-color:            transparent;
        text-color:                  @foreground;
        cursor:                      "default";
    }

    /*****----- Elements -----*****/
    element {
        enabled:                     true;
        spacing:                     10px;
        padding:                     4px;
        border-radius:               100%;
        background-color:            transparent;
        text-color:                  @foreground;
        cursor:                      pointer;
    }
    element normal.normal {
        background-color:            inherit;
        text-color:                  inherit;
    }
    element normal.urgent {
        background-color:            @urgent;
        text-color:                  @foreground;
    }
    element normal.active {
        background-color:            @active;
        text-color:                  @foreground;
    }
    element selected.normal {
        background-color:            @selected;
        text-color:                  @foreground;
    }
    element selected.urgent {
        background-color:            @urgent;
        text-color:                  @foreground;
    }
    element selected.active {
        background-color:            @urgent;
        text-color:                  @foreground;
    }
    element-icon {
        background-color:            transparent;
        text-color:                  inherit;
        size:                        32px;
        cursor:                      inherit;
    }
    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
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