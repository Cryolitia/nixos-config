{ ... }:
builtins.warn "Remember to update HomeAssistant image" {
  virtualisation.oci-containers = {
    backend = "podman";
    containers.homeassistant = {
      volumes = [ "/mnt/NAS/Data/HomeAssistant:/config" ];
      environment.TZ = "Asia/Shanghai";
      # https://github.com/home-assistant/core/pkgs/container/home-assistant/versions?filters%5Bversion_type%5D=tagged
      image = "ghcr.io/home-assistant/home-assistant:2025.5.3"; # Warning: if the tag does not change, the image will not be updated
      extraOptions = [
        "--network=host"
        #        "--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
      ];
      autoStart = true;
    };
  };

  networking.firewall.allowedTCPPorts = [
    # Web UI
    8123

    # SSDP
    40000

    # HomeKit
    21064
  ];
}
