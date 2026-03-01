{ ... }:

{
  imports = [ ../../graphic/home ];

  programs.niri.settings.outputs = {
    "DP-1" = {
      focus-at-startup = true;
      position = {
        x = 0;
        y = 0;
      };
    };
    "HDMI-A-1" = {
      scale = 2;
      position = {
        x = 0;
        y = -1200;
      };
    };
  };
}
