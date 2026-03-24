{ lib, ... }:

{
  imports = [ ../../graphic/home ];

  programs.git.signing = {
    signByDefault = false;
    key = "3E5D1772FC8A8EDD";
  };

  programs.kitty.font.size = 12.0;

  dconf.settings = {
    "org/gnome/desktop/interface".text-scaling-factor = 1.0;

    "org/gnome/shell/extensions/freon".hot-sensors = lib.mkForce [
      "__max__"
      "in0"
      "PPT"
      "fan1"
    ];
  };

  programs.hyprlock.settings.label = [
    {
      monitor = "";
      text = "cmd[update:60000] echo \"Battery $(cat /sys/class/power_supply/BAT0/status) $(cat /sys/class/power_supply/BAT0/capacity)%\"";
      font_size = 18;
      font_family = "Monospace";
      color = "rgba(216,222,233,0.5)";

      position = "1%, -2%";
      halign = "left";
      valign = "top";
    }
  ];

  programs.waybar.settings.mainBar = {
    network.format-wifi = " {signalStrength}%";
    clock.format = "{:%R}";
    temperature.hwmon-path = "/sys/devices/virtual/thermal/thermal_zone0/temp";
  };
}
