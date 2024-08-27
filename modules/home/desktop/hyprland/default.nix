{ config, lib, pkgs, ... }: {
  imports = [
    ./hyprpaper
    ./ags
    ./waybar
    ./mako
    ./wofi
  ];

  options = {
    module.desktop.hyprland.enable =
      lib.mkEnableOption "enables hyprland";
    module.desktop.hyprland.settings.enable =
      lib.mkEnableOption "enables hyprland settings";
    module.desktop.hyprland.hyprpaper.enable =
      lib.mkEnableOption "enables hyprpaper";
    module.desktop.hyprland.ags.enable =
      lib.mkEnableOption "enables ags";
    module.desktop.hyprland.waybar.enable =
      lib.mkEnableOption "enables waybar";
    module.desktop.hyprland.mako.enable =
      lib.mkEnableOption "enables mako";
    module.desktop.hyprland.wofi.enable =
      lib.mkEnableOption "enables wofi";
    module.desktop.hyprland.clipboard.enable =
      lib.mkEnableOption "enables clipboard";
  };

  config = lib.mkIf config.module.desktop.hyprland.settings.enable {
    home.packages = with pkgs; [
      hyprshot
      brightnessctl
      libnotify
      (lib.mkIf config.module.desktop.hyprland.clipboard.enable
        cliphist)
      (lib.mkIf config.module.desktop.hyprland.clipboard.enable
        wl-clip-persist)
    ];

    home.file."./.config/hypr/scripts".source = ./scripts;
    wayland.windowManager.hyprland.enable = config.module.desktop.hyprland.enable;
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "brightnessctl set +0"
        (lib.mkIf config.module.desktop.hyprland.hyprpaper.enable
          "hyprpaper")
        (lib.mkIf config.module.desktop.hyprland.ags.enable
          "ags")
        (lib.mkIf config.module.desktop.hyprland.waybar.enable
          "waybar")
        (lib.mkIf config.module.desktop.hyprland.clipboard.enable
          "wl-paste --type text --watch cliphist store")
        (lib.mkIf config.module.desktop.hyprland.clipboard.enable
          "wl-paste --type image --watch cliphist store")
        (lib.mkIf config.module.desktop.hyprland.clipboard.enable
          "wl-clip-persist --clipboard regular")
      ];

      "$terminal" = "kitty";
      "$browser" = "firefox-developer-edition";
      "$menu" = lib.mkIf config.module.desktop.hyprland.wofi.enable "wofi --show drun"; # run,drun,dmenu

      "monitor" = ", preferred, auto, 1";

      master = {
        "no_gaps_when_only" = "0";
        "new_on_top" = "true";
      };

      misc = {
        "disable_hyprland_logo" = "true";
        "new_window_takes_over_fullscreen" = "1";
      };

      gestures = {
        "workspace_swipe" = "true";
      };

      general = {
        "border_size" = "2";
        "col.active_border" = "rgb(333333)";
        "col.inactive_border" = "rgb(222222)";

        "gaps_in" = "5";
        "gaps_out" = "5";

        "layout" = "master";

        "allow_tearing" = "false";
      };

      decoration = {
        "rounding" = "10";
        "dim_inactive" = "true";
        "dim_strength" = "0.2";
      };

      animations = {
        "enabled" = "yes";
        "animation" = [
          "workspaces, 1, 3, default"
          "windows,    1, 3, default, slide"
          "border,     1, 3, default"
          "fade,       1, 3, default"
        ];
      };

      input = {
        "kb_layout" = "us, ru";
        "kb_options" = "grp:win_space_toggle";

        "repeat_delay" = "300";
        "repeat_rate" = "40";

        "follow_mouse" = "1";
        "float_switch_override_focus" = "0";
        "mouse_refocus" = "true";

        "numlock_by_default" = "true";

        touchpad = {
          "tap-to-click" = "true";
          "natural_scroll" = "true";
          "disable_while_typing" = "true";
        };

        "sensitivity" = "0"; # -1.0 - 1.0, 0 means no modification.
      };

      "$mainMod" = "SUPER";
      "$shift" = "SHIFT";
      "$alt" = "ALT";
      "$ctrl" = "CTRL";

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        # Volume
        ", XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/volume --inc"
        ", XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/volume --dec"
        ", XF86AudioMute, exec, ~/.config/hypr/scripts/volume --toggle"
        #", XF86AudioMicMute, exec, ~/.config/hypr/scripts/volume --toggle-mic"

        # Screen brightness
        ", XF86MonBrightnessUp, exec, ~/.config/hypr/scripts/backlight --inc"
        ", XF86MonBrightnessDown, exec, ~/.config/hypr/scripts/backlight --dec"
      ];

      bind =
        [
          # Programs
          "$mainMod, Q, killactive"
          "$mainMod, D, exec, $menu"
          "$mainMod, X, exec, $terminal"
          "$mainMod, B, exec, $browser"
          "$mainMod, F, togglefloating,"

          # Move focused window
          "$mainMod, H, movewindow, l"
          "$mainMod, J, movewindow, d"
          "$mainMod, K, movewindow, u"
          "$mainMod, L, movewindow, r"

          # Move focused window between workspace
          "$mainMod $alt $shift, l, movetoworkspace, e+1"
          "$mainMod $alt $shift, h, movetoworkspace, e-1"

          # Move between workspace
          "$mainMod $alt, l, workspace, e+1"
          "$mainMod $alt, h, workspace, e-1"

          # Toggle fullscreen mode
          "$mainMod, F11, fullscreen, 0"
          "$mainMod $alt, F11, fullscreen, 1"

          # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod $shift, S, movetoworkspace, special:magic"

          # Switch between windows in workspace
          "$mainMod, Tab, cyclenext,"
          "$mainMod, Tab, bringactivetotop,"

          # Screenshots
          ", PRINT, exec, hyprshot -m output -c -o ~/Pictures/Screenshots"
          "$mainMod, PRINT, exec, hyprshot -m window -c -o ~/Pictures/Screenshots"
          "$mainMod $shift, PRINT, exec, hyprshot -m region -c -o ~/Pictures/Screenshots"

          # Power
          "$ctrl $alt, DELETE, exec, systemctl -i poweroff"
          "$ctrl $alt $shift, DELETE, exec, systemctl -i reboot"

          # Keyboard brightness
          ", XF86KbdBrightness, exec, ~/.config/hypr/scripts/kbbacklight --inc"

          # Clipboard history
          (lib.mkIf (config.module.desktop.hyprland.wofi.enable && config.module.desktop.hyprland.clipboard.enable)
            "SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy")
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod $shift, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
    wayland.windowManager.hyprland.extraConfig = ''
      # Submaps
      $submap_resize = 🍆 resize
      $submap_audio = 🔊 audio
      $submap_exit = 🏁 exit

      bind = $mainMod$shift, a, submap, $submap_audio
      bind = $mainMod$shift, r, submap, $submap_resize
      bind = $mainMod$shift, e, submap, $submap_exit

      submap = $submap_audio
        binde = , k, exec, ~/.config/hypr/scripts/volume --inc
        binde = , j, exec, ~/.config/hypr/scripts/volume --dec

        bind = , return, submap, reset
        bind = , escape, submap, reset
      submap = reset

      submap = $submap_resize
        binde = , h, resizeactive, -15 0
        binde = , l, resizeactive, 15 0
        binde = , k, resizeactive, 0 -15
        binde = , j, resizeactive, 0 15

        bind  = , escape, submap, reset
        bind  = , return, submap, reset
      submap = reset

      submap = $submap_exit
        bind = , e, exit,
        #bind = , l, exec, exit-wm lock
        #bind = , l, submap, reset
        bind = , s, exec, systemctl -i suspend
        bind = , s, submap, reset
        bind = , r, exec, systemctl -i reboot
        bind = , r, submap, reset
        bind = , h, exec, systemctl -i hibernate
        bind = , h, submap, reset
        bind = , p, exec, systemctl -i poweroff
        bind = , p, submap, reset

        bind = , return, submap, reset
        bind = , escape, submap, reset
      submap = reset
    '';
  };
}
