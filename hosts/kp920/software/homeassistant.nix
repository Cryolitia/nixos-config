{ lib, ... }:
let
  version = (lib.importJSON ../../../version.json).home-assistant;
in
{
  virtualisation.oci-containers = {
    backend = "podman";
    containers.homeassistant = {
      volumes = [ "/var/lib/data/HomeAssistant:/config" ];
      environment.TZ = "Asia/Shanghai";
      # https://github.com/home-assistant/core/pkgs/container/home-assistant/versions?filters%5Bversion_type%5D=tagged
      image = "${version.url}:${version.latest}"; # Warning: if the tag does not change, the image will not be updated
      extraOptions = [
        "--network=host"
        #        "--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
      ];
      autoStart = true;
      capabilities = {
        NET_RAW = true;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    # Web UI
    # 8123

    # SSDP
    40000

    # HomeKit
    21064
  ];
  me.cryolitia.services.nginx.internal."ha" = 8123;
}
