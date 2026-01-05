{
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "niri.service";
    };
    style = ./waybar.css;
    settings = {
      mainBar = {
        layer = "top"; # Waybar at top layer
        # "position"= "bottom"; # Waybar position (top|bottom|left|right)
        height = 30; # Waybar height (to be removed for auto height)
        # "width"= 1280; # Waybar width
        spacing = 4; # Gaps between modules (4px)
        # Choose the order of the modules
        modules-left = [
          "niri/workspaces"
          "wlr/taskbar"
          "mpris"
        ];
        modules-center = [
          "clock"
          "niri/window"
        ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
        ]
        ++ (lib.optionals osConfig.hardware.bluetooth.enable [ "bluetooth" ])
        ++ [
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "keyboard-state"
          "battery"
          "tray"
        ];
        "niri/workspaces" = {
          all-outputs = false;
          on-click = "activate";
          active-first = false;
        };
        "niri/window" = {
          separate-outputs = true;
        };
        "wlr/taskbar" = {
          all-outputs = false;
          format = "{icon}";
          icon-size = 16;
          tooltip = true;
          tooltip-format = "{title}";
          active-first = false;
          on-click = "activate";
        };
        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
        mpris = {
          format = "{status_icon} {player} {title}-{artist}-{album}";
          format-stopped = "";
          format-alt = "{status_icon} {player}= {title}";
          status-icons = {
            playing = "▶";
            paused = "⏸";
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          # "icon-size"= 21;
          spacing = 10;
        };
        clock = {
          # "timezone"= "America/New_York";
          # tooltip-format = ''<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>'';
          format = "{:%F %R}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          critical-threshold = 80;
          # "format-critical"= "{temperatureC}°C {icon}";
          format = "{temperatureC}°C ";
        };
        backlight = {
          # "device"= "acpi_video1";
          format = "{percent}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        battery = {
          states = {
            # "good"= 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "";
          format-discharging = "{capacity}% {icon}";
          tooltip-format = "{capacity}% {timeTo}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        network = {
          # "interface"= "wlp2*"; # (Optional) To force the use of this interface
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} 󰈀";
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "{ifname} via {gwaddr} {frequency}MHz";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}= {ipaddr}/{cidr}";
        };
        bluetooth = {
          "format" = " {status}";
          "format-disabled" = ""; # an empty format will hide the module
          "format-connected" = " {num_connections} connected";
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          on-click = "${lib.getExe pkgs.kitty} --class floating ${lib.getExe pkgs.bluetui}";
        };

        pulseaudio = {
          scroll-step = 5; # %; can be a float
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰝟 {icon} {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "${lib.getExe pkgs.kitty} --class floating ${lib.getExe pkgs.wiremix}";
        };
      };
    };
  };
}
