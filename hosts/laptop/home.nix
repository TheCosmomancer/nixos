{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cosmomancer";
  home.homeDirectory = "/home/cosmomancer";
  

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
  initExtra = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh\ntypeset -g POWERLEVEL9K_INSTANT_PROMPT=off\nfastfetch";
  };
  services.hyprpaper ={
    enable = true;
    settings = {
        preload = ["/etc/nixos/media/astronautdesert.png"];
        wallpaper = [",/etc/nixos/media/astronautdesert.png"];
    }; 
  };
  #qt = {
    #enable = true;
    #platformTheme = "kde";
    #style = {
        #name = ;
        #package = pkgs.;
    #};
  #};
  #gtk = {
    #enable = true;
    #cursorTheme ={
        #package = pkgs.bibata-cursors;
        #name = "Bibata-Modern-Classic";
    #};
    #theme = {
        #package = pkgs.;
        #name = ;
    #};
    #iconTheme = {
        #package = pkgs.;
        #name = ;
    #};
  #};
  nixpkgs.config.allowUnfree = true;
  programs.vscode = {
    enable = true;
    profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        userSettings = {
            "telemetry.telemetryLevel" = "off";
            "files.autoSave" = "onFocusChange";
            "editor.formatOnPaste" = true;
            "workbench.preferredHighContrastColorTheme" = "Default Dark Modern";
            "terminal.external.linuxExec" = "ghostty";
        };
        extensions = with pkgs.vscode-extensions; [
        bbenoist.nix 
        ms-python.python 
        esbenp.prettier-vscode 
        visualstudioexptteam.vscodeintellicode
        jgclark.vscode-todo-highlight
        james-yu.latex-workshop
        ];
    };
  };
  programs.firefox = {
    enable = true;
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
  # The home.packages option allows you to install Nix packages into your
  # environment.
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
        "$menu" = "rofi --show drun";
        "$screenshot" = "grimblast --notify --freeze save area ~/grimblast/screenshot.png";
        exec-once = [
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "systemctl --user start polkit-gnome-authentication-agent-1"
            "hyprctl setcursor Bibata-Modern-Classic 24"
            "hyprpanel"
            "nm-applet"
            "hyprpaper"
        ];
        env = [
            "XCURSOR_SIZE,24"
            "HYPRCURSOR_SIZE,24"
            "WLR_NO_HARDWARE_CURSORS,1"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
        ];
        general = {
            gaps_in = 3;
            gaps_out = 15;
            border_size = 1;
            "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            "col.inactive_border" = "rgba(595959aa)";
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
                color = "rgba(1a1a1aee)";
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
            "$mainMod, A, exec, rofi -show drun -show-icons"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, S, exec, $screenshot"
            "$mainMod, C, killactive,"
            "$mainMod, M, exit,"
            "$mainMod, V, togglefloating,"

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
        ];
    };
  };
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

  #just don't change this and you'll be fine
  home.stateVersion = "24.11";
}
