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
            "keyColor": "38;5;69", 
        },
        {
            "type": "terminal",
            "format": "{1}",
            "key": " ",
            "keyColor": "38;5;153", 
        },
        "break"
        ]
    }
    '';
    ".config/hypr/hyprpaper.conf".text = ''
    preload = /etc/nixos/media/astronautdesert.png
    wallpaper = , /etc/nixos/media/astronautdesert.png
    '';
    ".config/hypr/hyprland.conf".text = ''
    # #######################################################################################
    # AUTOGENERATED HYPR CONFIG.
    # PLEASE USE THE CONFIG PROVIDED IN THE GIT REPO /examples/hypr.conf AND EDIT IT,
    # OR EDIT THIS ONE ACCORDING TO THE WIKI INSTRUCTIONS.
    # #######################################################################################


    # This is an example Hyprland config file.
    # Refer to the wiki for more information.
    # https://wiki.hyprland.org/Configuring/

    # Please note not all available settings / options are set here.
    # For a full list, see the wiki

    # You can split this configuration into multiple files
    # Create your files separately and then link them to this file like this:
    # source = ~/.config/hypr/myColors.conf


    ################
    ### MONITORS ###
    ################

    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor = eDP-1, 1920x1080@60, 0x0, 1
    monitor = HDMI-A-1, 1920x1080@75, 1920x0, 1, mirror, eDP-1
    ###################
    ### MY PROGRAMS ###
    ###################

    # See https://wiki.hyprland.org/Configuring/Keywords/

    # Set programs that you use
    $terminal = ghostty
    $fileManager = thunar
    $menu = rofi --show drun


    #################
    ### AUTOSTART ###
    #################

    # Autostart necessary processes (like notifications daemons, status bars, etc.)
    # Or execute your favorite apps at launch like this:

    # exec-once = $terminal
    # exec-once = nm-applet &
    # exec-once = waybar & hyprpaper & firefox


    #############################
    ### ENVIRONMENT VARIABLES ###
    #############################

    # See https://wiki.hyprland.org/Configuring/Environment-variables/

    env = XCURSOR_SIZE,24
    env = HYPRCURSOR_SIZE,24
    env = WLR_NO_HARDWARE_CURSORS,1
    #env = AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card2
    #####################
    ### LOOK AND FEEL ###
    #####################

    # Refer to https://wiki.hyprland.org/Configuring/Variables/

    # https://wiki.hyprland.org/Configuring/Variables/#general
    general {
        gaps_in = 5
        gaps_out = 20

        border_size = 2

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false

        layout = dwindle
    }

    # https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration {
        rounding = 10

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0
        inactive_opacity = 1.0

        shadow {
            enabled = true
            range = 4
            render_power = 3
            color = rgba(1a1a1aee)
        }

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur {
            enabled = true
            size = 3
            passes = 1

            vibrancy = 0.1696
        }
    }

    # https://wiki.hyprland.org/Configuring/Variables/#animations
    animations {
        enabled = yes, please :)

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = easeOutQuint,0.23,1,0.32,1
        bezier = easeInOutCubic,0.65,0.05,0.36,1
        bezier = linear,0,0,1,1
        bezier = almostLinear,0.5,0.5,0.75,1.0
        bezier = quick,0.15,0,0.1,1

        animation = global, 1, 10, default
        animation = border, 1, 5.39, easeOutQuint
        animation = windows, 1, 4.79, easeOutQuint
        animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
        animation = windowsOut, 1, 1.49, linear, popin 87%
        animation = fadeIn, 1, 1.73, almostLinear
        animation = fadeOut, 1, 1.46, almostLinear
        animation = fade, 1, 3.03, quick
        animation = layers, 1, 3.81, easeOutQuint
        animation = layersIn, 1, 4, easeOutQuint, fade
        animation = layersOut, 1, 1.5, linear, fade
        animation = fadeLayersIn, 1, 1.79, almostLinear
        animation = fadeLayersOut, 1, 1.39, almostLinear
        animation = workspaces, 1, 1.94, almostLinear, fade
        animation = workspacesIn, 1, 1.21, almostLinear, fade
        animation = workspacesOut, 1, 1.94, almostLinear, fade
    }

    # Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
    # "Smart gaps" / "No gaps when only"
    # uncomment all if you wish to use that.
    # workspace = w[tv1], gapsout:0, gapsin:0
    # workspace = f[1], gapsout:0, gapsin:0
    # windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
    # windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
    # windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
    # windowrulev2 = rounding 0, floating:0, onworkspace:f[1]

    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    dwindle {
        pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true # You probably want this
    }

    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    master {
        new_status = master
    }

    # https://wiki.hyprland.org/Configuring/Variables/#misc
    misc {
        force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
        middle_click_paste = false
    }


    #############
    ### INPUT ###
    #############

    # https://wiki.hyprland.org/Configuring/Variables/#input
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        sensitivity = -0.5 # -1.0 - 1.0, 0 means no modification.

        touchpad {
            natural_scroll = false
        }
    }

    # https://wiki.hyprland.org/Configuring/Variables/#gestures
    gestures {
        workspace_swipe = false
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
    device {
        name = epic-mouse-v1
        sensitivity = -0.5
    }


    ###################
    ### KEYBINDINGS ###
    ###################

    # See https://wiki.hyprland.org/Configuring/Keywords/
    $mainMod = SUPER # Sets "Windows" key as main modifier

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, Q, exec, $terminal
    bind = $mainMod, C, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, E, exec, $fileManager
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, R, exec, $menu
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle
    bind = $mainMod, A, exec, rofi -show drun -show-icons
    input {
        kb_layout=us,ir
        kb_options=grp:alt_shift_toggle,caps:super
    }
    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Example special workspace (scratchpad)
    bind = $mainMod, S, togglespecialworkspace, magic
    bind = $mainMod SHIFT, S, movetoworkspace, special:magic

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    # Laptop multimedia keys for volume and LCD brightness
    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

    # Requires playerctl
    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous

    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

    # Example windowrule v1
    # windowrule = float, ^(kitty)$

    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

    # Ignore maximize requests from apps. You'll probably like this.
    windowrulev2 = suppressevent maximize, class:.*

    # Fix some dragging issues with XWayland
    windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = systemctl --user start hyprpolkitagent
    exec-once = hyprctl setcursor Bibata-Modern-Classic 24
    exec-once = hyprpanel
    exec-once = nm-applet
    exec-once = hyprpaper
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
