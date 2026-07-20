{ config, ... }:

{
  services.kmscon = {
    enable = true;
    config.hwaccel = config.services.xserver.enable;
  };
}
