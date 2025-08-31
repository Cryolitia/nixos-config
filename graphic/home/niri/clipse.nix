{ ... }:
{
  services.clipse = {
    enable = true;
    systemdTarget = "niri.service";
    imageDisplay.type = "kitty";
  };
}
