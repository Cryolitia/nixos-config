{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adawaita";
    };
    settings = {
      global = {
        follow = "mouse";
        font = "Source Han Serif SC 12";
        format = ''<small>%a</small>\n<b>%s</b>\n%b'';
        browser = "/usr/bin/env xdg-open";
        corner_radius = 10;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
      };
      urgency_low = {
        background = "#2E3440C0";
        foreground = "#ECEFF4";
        frame_color = "#4C566A";
        timeout = 10;
      };
      urgency_normal = {
        background = "#3B4252C0";
        foreground = "#88C0D0";
        frame_color = "#4C566A";
        timeout = 10;
      };
      urgency_critical = {
        background = "#434C5EC0";
        foreground = "#BF616A";
        frame_color = "#4C566A";
        timeout = 0;
      };
    };
  };
}
