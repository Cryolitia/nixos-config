{ inputs, pkgs, osConfig, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # inputs.hyprland-plugin.packages.${pkgs.system}.hyprbars
    ];
    settings = {
      monitor = ",preferred,auto,auto";
      env = "XCURSOR_SIZE,24";

      input = {
        kb_layout = "us";
        numlock_by_default = true;
        follow_mouse = 1;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          clickfinger_behavior = true;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 10;
        active_opacity = 0.8;
        fullscreen_opacity = 0.8;

        blur = {
          enabled = true;
          size = 8;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        dim_inactive = true;
        dim_strength = 0.2;
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
      };

      misc = {
        force_hypr_chan = true;
      };

      "$mainMod" = "SUPER";

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = [
        "$mainMod, T, exec, kitty"
        "$mainMod, Q, killactive,"
        "$mainMod, M, fullscreen, 1"
        "$mainMod, F, togglefloating,"
        "$mainMod, R, exec, anyrun"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move focus with mainMod + arrow keys
        "$mainMod SHIFT, left, swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up,swapwindow, u"
        "$mainMod SHIFT, down, swapwindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod SHIFT, page_up, movetoworkspace, -1"
        "$mainMod SHIFT, page_down, movetoworkspace, +1"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, page_up, workspace, -1"
        "$mainMod, page_down, workspace, +1"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, -1"
        "$mainMod, mouse_up, workspace, +1"

        "SUPER, V, exec, cliphist list | anyrun --plugins ${inputs.anyrun.packages.${pkgs.system}.stdin}/lib/libstdin.so | cliphist decode | wl-copy"

        #SwayOSD
        ", XF86AudioMute, exec, swayosd --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd --input-volume mute-toggle"

        ", Print, exec, hyprshot -m region --raw | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"
        "$mainMod, Print, exec, hyprshot -m window --raw | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"
        "$mainMod SHIFT, Print, exec, hyprshot -m output --raw | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = [
        "waybar"
        "dunst"
        "wpaperd"
        "wl-clip-persist --clipboard both"
        "wl-paste --type text --watch cliphist store"
        "udiskie &"
        #FIx me: hyprshot
        #fix me: kindex
        "fcitx5"
        "nm-applet"
      ];

      bindle = [
        # swayosd
        ", XF86AudioRaiseVolume, exec, swayosd --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd --output-volume lower"
        ", XF86MonBrightnessUp,exec,swayosd --brightness raise"
        ", XF86MonBrightnessDown,exec,swayosd --brightness lower"
      ];

      bindl = [
        ", Caps_Lock, exec, swayosd --caps-lock"
      ];
    };
  };
}
