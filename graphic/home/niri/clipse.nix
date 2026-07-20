{ ... }:
{
  services.clipse = {
    enable = true;
    systemdTarget = "niri.service";
    settings.imageDisplay.type = "kitty";
  };
}
