{ config, pkgs, ... }:
{
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
        "$screenshot" = "hyprshot -o ~/hyprshot -z -m region";
        "$browser" = "librewolf";
        "$editor" = "code";
        "$obsidian" = "obsidian";
        "$sysvital" = "missioncenter";
        exec-once = [
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "systemctl --user start polkit-gnome-authentication-agent-1"
            "hyprctl setcursor Bibata-Modern-Classic 24"
            "eww open bar"
            "nm-applet"
            # "mpc"
            "hyprpaper"
            "~/BehrazWebUI/ai_panel.py"
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
            border_size = 0;
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
            "$mainMod, A, exec, $menu"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, P, exec, $screenshot"
            "$mainMod, D, exec, $browser"
            "$mainMod, X, exec, $editor"
            "$mainMod, O, exec, $obsidian"
            "$mainMod, Escape, exec, $sysvital"
            "$mainMod, C, killactive,"
            "$mainMod, M, exit,"
            "$mainMod, V, togglefloating,"
            "$mainMod, T, exec, pkill -SIGUSR1 -f ai_panel.py"

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
    };
  };
}