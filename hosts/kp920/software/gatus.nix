{ lib, ... }:
let
  version = (lib.importJSON ../../../version.json).gatus;
in
{
  virtualisation.oci-containers = {
    backend = "podman";
    containers.gatus = {
      volumes = [ "/var/lib/data/gatus:/config" ];
      environment.TZ = "Asia/Shanghai";
      # https://github.com/home-assistant/core/pkgs/container/home-assistant/versions?filters%5Bversion_type%5D=tagged
      image = "${version.url}:${version.latest}"; # Warning: if the tag does not change, the image will not be updated
      autoStart = true;
      extraOptions = [
        "--network=host"
        "--privileged"
      ];
      capabilities = {
        NET_RAW = true;
      };
    };
  };

  me.cryolitia.services.nginx.external."status" = 1081;
}
