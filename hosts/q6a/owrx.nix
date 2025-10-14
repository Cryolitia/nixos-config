{ lib, ... }:
let
  version = (lib.importJSON ../../version.json).owrx;
in
{
  virtualisation.oci-containers = {
    backend = "podman";
    containers.owrx = {
      volumes = [
        "/var/lib/owrx/etc:/etc/openwebrx"
        "/var/lib/owrx/var:/var/lib/openwebrx"
        "/var/lib/owrx/plugins:/usr/lib/python3/dist-packages/htdocs/plugins"
      ];
      environment.TZ = "Asia/Shanghai";
      # https://github.com/home-assistant/core/pkgs/container/home-assistant/versions?filters%5Bversion_type%5D=tagged
      image = "${version.url}@${version.digest}"; # Warning: if the tag does not change, the image will not be updated
      autoStart = true;
      extraOptions = [
        "--privileged"
      ];
      ports = [ "8073:8073" ];
      devices = [ "/dev/bus/usb:/dev/bus/usb" ];
    };
  };
}
