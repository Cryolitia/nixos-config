{ lib, ... }:
{
  services.gatus.enable = true;

  systemd.services.gatus.environment.GATUS_CONFIG_PATH =
    lib.mkForce "/var/lib/data/gatus/config.yaml";

  me.cryolitia.services.nginx.external."status" = 1081;
}
