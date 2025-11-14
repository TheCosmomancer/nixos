{ config, inputs, pkgs, ... }:
{
    stylix = {
        enable = true;
        targets.firefox.enable = true;
        targets.firefox.profileNames = [ "default" ];
        targets.ghostty.enable = true;
    };
    programs = {
        ghostty.enable = true;
    };

# SECTION: HYPRLAND

    services.hyprpaper ={
    enable = true;
    settings = {
        preload = ["/etc/nixos/media/nightcabingirl.png"];
        wallpaper = [",/etc/nixos/media/nightcabingirl.png"];
    }; 
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
        monitor = [
            "eDP-1, 1920x1080@60, 0x0, 1"
            "HDMI-A-1, 1920x1080@75, 1920x0, 1, mirror, eDP-1"
        ];
        "$mainMod" = "SUPER";
        "$terminal" = "ghostty";
        "$fileManager" = "thunar";
        "$menu" = "rofi -show drun";
        "$screenshot" = "hyprshot -o ~/Pictures/hyprshot -z -m region";
        "$browser" = "firefox";
        "$VPN" = "nekoray";
        "$editor" = "code";
        "$obsidian" = "obsidian";
        "$sysvital" = "missioncenter";
        exec-once = [
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "systemctl --user start polkit-gnome-authentication-agent-1"
            "eww open bar"
            "nm-applet"
            # "mpc"
            "hyprpaper"
            "~/BehrazWebUI/ai_panel.py"
        ];
        env = [
            "WLR_NO_HARDWARE_CURSORS,1"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
        ];
        general = {
            gaps_in = 3;
            gaps_out = 15;
            border_size = 0;
            # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            # "col.inactive_border" = "rgba(595959aa)";
            layout = "dwindle";
            snap = {
                enabled = true;
            };
        };
        decoration = {
            rounding = 7;
            shadow = {
                enabled = true;
                range = 4;
                render_power = 3;
                # color = "rgba(1a1a1aee)";
            };
            blur = {
                enabled = true;
                size = 3;
                passes = 1;
                vibrancy = "0.1696";
            };
        };
        animations = {
            enabled = "yes, please :)";

            bezier = [
                "easeOutQuint,0.23,1,0.32,1"
                "easeInOutCubic,0.65,0.05,0.36,1"
                "linear,0,0,1,1"
                "almostLinear,0.5,0.5,0.75,1.0"
                "quick,0.15,0,0.1,1"
            ];
            animation = [
                "global, 1, 10, default"
                "border, 1, 5.39, easeOutQuint"
                "windows, 1, 4.79, easeOutQuint"
                "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                "windowsOut, 1, 1.49, linear, popin 87%"
                "fadeIn, 1, 1.73, almostLinear"
                "fadeOut, 1, 1.46, almostLinear"
                "fade, 1, 3.03, quick"
                "layers, 1, 3.81, easeOutQuint"
                "layersIn, 1, 4, easeOutQuint, fade"
                "layersOut, 1, 1.5, linear, fade"
                "fadeLayersIn, 1, 1.79, almostLinear"
                "fadeLayersOut, 1, 1.39, almostLinear"
                "workspaces, 1, 1.94, almostLinear, fade"
                "workspacesIn, 1, 1.21, almostLinear, fade"
                "workspacesOut, 1, 1.94, almostLinear, fade"
            ];
        };
        dwindle = {
        force_split = 1;
        preserve_split = true;
        split_bias = 1;
        };

        misc = {
            force_default_wallpaper = 2;
        };
        input = {
            kb_layout = "us,ir";
            kb_options = "grp:alt_shift_toggle,caps:super";
            numlock_by_default = true;
            sensitivity = "-0.5"; # -1.0 - 1.0, 0 means no modification.
            follow_mouse = 1;
            #0 - Cursor movement will not change focus.
            #1 - Cursor movement will always change focus to the window under the cursor.
            #2 - Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
            #3 - Cursor focus will be completely separate from keyboard focus. Clicking on a window will not change keyboard focus.
        };
        bind = [
            "$mainMod, Q, exec, $terminal"
            "$mainMod, A, exec, $menu"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, P, exec, $screenshot"
            "$mainMod, D, exec, $browser"
            "$mainMod, X, exec, $editor"
            "$mainMod, O, exec, $obsidian"
            "$mainMod, Escape, exec, $sysvital"
            "$mainMod, C, killactive,"
            "$mainMod, M, exit,"
            "ALT, Tab, workspace, previous"

            # Move focus with mainMod + arrow keys
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            # Switch workspaces with mainMod + [0-9]
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"

            # Example special workspace (scratchpad)
            #bind = $mainMod, S, togglespecialworkspace, magic
            #bind = $mainMod SHIFT, S, movetoworkspace, special:magic

            # Scroll through existing workspaces with mainMod + scroll
            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"
        ];
        bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
        ];
        bindel = [
            # Laptop multimedia keys for volume and LCD brightness
            " ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            " ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            " ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            " ,XF86MonBrightnessUp, exec, brightnessctl s 10%+"
            " ,XF86MonBrightnessDown, exec, brightnessctl s 10%-"

            # Requires playerctl
            " , XF86AudioNext, exec, playerctl next"
            " , XF86AudioPause, exec, playerctl play-pause"
            " , XF86AudioPlay, exec, playerctl play-pause"
            " , XF86AudioPrev, exec, playerctl previous"
        ];
        windowrulev2 = [ 
            "suppressevent maximize, class:.*"
            # Fix some dragging issues with XWayland
            "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
            "stayfocused, title:Authenticate"
        ];
        layerrule = [
            "blur, eww-bar"
            "xray 1, eww-bar"
        ];
        ecosystem = {
            "no_update_news" = true;
            "no_donation_nag" = true;
        };
    };
  };


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
            # "workbench.colorTheme" = "Gruvbox Dark Hard";
            # "editor.fontFamily" = "'JetBrains Mono Nerd Font'";
        };
        extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-python.vscode-pylance
        esbenp.prettier-vscode
        jgclark.vscode-todo-highlight
        james-yu.latex-workshop
        mkhl.direnv
        rust-lang.rust-analyzer
        ms-toolsai.jupyter
        # jdinhlife.gruvbox
        charliermarsh.ruff
        supermaven.supermaven
        myriad-dreamin.tinymist
        ];
    };
  };


# SECTION: ZSH
programs.zsh = {
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
    mkcd = "mkdir -p \"$1\" && cd \"$1\"";
    ls = "eza --git -F --color-scale --icons --group-directories-first";
    lsa = "eza --git -F -a --color-scale --icons --group-directories-first";
    vibegit = "git add -A && git commit -m \".\" && git push";
    pingg = "ping google.com";
  };



# SECTION: DOTFILES


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