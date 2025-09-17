{ ... }:
builtins.warn "Remember to update gatus image" {
  virtualisation.oci-containers = {
    backend = "podman";
    containers.gatus = {
      volumes = [ "/var/lib/data/gatus:/config" ];
      environment.TZ = "Asia/Shanghai";
      # https://github.com/home-assistant/core/pkgs/container/home-assistant/versions?filters%5Bversion_type%5D=tagged
      image = "ghcr.io/twin/gatus:v5.23.2"; # Warning: if the tag does not change, the image will not be updated
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
