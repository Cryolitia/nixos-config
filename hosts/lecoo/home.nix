{ ... }:
{

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

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
