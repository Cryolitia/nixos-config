{
  lib,
  osConfig,
  config,
  pkgs,
  ...
}:
let
  sh = config.lib.niri.actions.spawn "sh" "-c";
in
lib.optionals osConfig.programs.niri.enable {

  imports = [
    ./dunst.nix
    ./wpaperd.nix
    ./waybar.nix
    ./hyprlock.nix
    ./clipse.nix
    ./fuzzel.nix
    ./nm-applet.nix
  ];

  programs.niri = {
    settings = {
      environment = {
        "NIXOS_OZONE_WL" = "1";
        "DISPLAY" = ":0";
      };

      outputs = {
        "eDP-1".scale = 2;
      };

      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 12.0;
            bottom-right = 12.0;
            top-left = 12.0;
            top-right = 12.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            {
              app-id = "floating";
            }
          ];
          open-floating = true;
          default-column-width.proportion = 0.5;
          default-window-height.proportion = 0.5;
        }
        {
          matches = [
            {
              app-id = "steam";
              title = ''^notificationtoasts_\d+_desktop$'';
            }
          ];
          default-floating-position = {
            x = 10;
            y = 10;
            relative-to = "top-right";
          };
        }
        {
          matches = [
            {
              app-id = "code";
            }
          ];
          opacity = 0.85;
          draw-border-with-background = false;
        }
      ];

      layer-rules = [
        {
          matches = [ { namespace = "^notifications$"; } ];
          block-out-from = "screencast";
        }
      ];

      prefer-no-csd = true;

      xwayland-satellite.path = "${lib.getExe pkgs.xwayland-satellite-stable}";

      layout = {
        focus-ring = {
          active.color = "#88c0d0";
          inactive.color = "#81a1c1";
          urgent.color = "#bf616a";
        };
      };

      binds = with config.lib.niri.actions; {
        "Mod+T" = {
          action.spawn = "kitty";
        };
        "Mod+Q" = {
          action = close-window;
          repeat = false;
        };
        "Mod+Shift+Slash" = {
          action = show-hotkey-overlay;
          repeat = false;
        };
        "Mod+V" = {
          action = sh "kitty --class floating clipse";
        };
        "Mod+D" = {
          action.spawn = "fuzzel";
        };

        "XF86AudioRaiseVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        "XF86AudioMute".action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        "Alt+Tab".action = toggle-overview;

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-workspace-down;
        "Mod+Up".action = focus-workspace-up;
        "Mod+Right".action = focus-column-right;

        "Mod+J".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+I".action = focus-workspace-up;
        "Mod+K".action = focus-workspace-down;

        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Down".action = move-column-to-workspace-down;
        "Mod+Ctrl+Up".action = move-column-to-workspace-up;
        "Mod+Ctrl+Right".action = move-column-right;

        "Mod+Ctrl+J".action = move-column-left;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;
        "Mod+Ctrl+K".action = move-column-to-workspace-down;
        "Mod+Ctrl+L".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;

        "Mod+Shift+Left".action = focus-monitor-left;
        "Mod+Shift+Down".action = focus-monitor-down;
        "Mod+Shift+Up".action = focus-monitor-up;
        "Mod+Shift+Right".action = focus-monitor-right;
        "Mod+Shift+J".action = focus-monitor-left;
        "Mod+Shift+K".action = focus-monitor-down;
        "Mod+Shift+I".action = focus-monitor-up;
        "Mod+Shift+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+I".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+Ctrl+Page_Down".action = move-workspace-down;
        "Mod+Ctrl+Page_Up".action = move-workspace-up;

        "Mod+O".action = focus-window-up;
        "Mod+M".action = focus-window-down;
        "Mod+Ctrl+O".action = move-window-up;
        "Mod+Ctrl+M".action = move-window-down;

        "Mod+WheelScrollDown".action = focus-column-right;
        "Mod+WheelScrollUp".action = focus-column-left;

        "Mod+Ctrl+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+WheelScrollUp".action = move-column-left;

        "Mod+Shift+WheelScrollDown".action = focus-window-down;
        "Mod+Shift+WheelScrollUp".action = focus-window-up;

        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-to-workspace-down;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-to-workspace-up;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        #"Mod+Ctrl+1".action = move-column-to-workspace 1;
        #"Mod+Ctrl+2".action = move-column-to-workspace 2;
        #"Mod+Ctrl+3".action = move-column-to-workspace 3;
        #"Mod+Ctrl+4".action = move-column-to-workspace 4;
        #"Mod+Ctrl+5".action = move-column-to-workspace 5;
        #"Mod+Ctrl+6".action = move-column-to-workspace 6;
        #"Mod+Ctrl+7".action = move-column-to-workspace 7;
        #"Mod+Ctrl+8".action = move-column-to-workspace 8;
        #"Mod+Ctrl+9".action = move-column-to-workspace 9;

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+R".action = switch-preset-column-width;
        "Mod+F".action = maximize-column;
        "Mod+Ctrl+F".action = toggle-window-floating;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+C".action = center-column;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Print".action = screenshot;
        # "Ctrl+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;

        "Mod+Shift+E".action = quit;
        "Mod+P".action = sh "systemd-run -u hyprlock --service-type=exec --user hyprlock --grace 0";
        "Mod+Shift+P".action =
          sh "systemd-run -u hyprlock --service-type=exec --user hyprlock --grace 15 && sleep 5 && niri msg action power-off-monitors";
      };
    };
  };
}
