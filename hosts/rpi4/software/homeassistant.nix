{ ... }:

{
  virtualisation.oci-containers = {
    backend = "podman";
    containers.homeassistant = {
      volumes = [ "/mnt/NAS/Data/HomeAssistant:/config" ];
      environment.TZ = "Asia/Shanghai";
      image = "ghcr.io/home-assistant/home-assistant:2023.5.4"; # Warning: if the tag does not change, the image will not be updated
      extraOptions = [ 
        "--network=host" 
#        "--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
      ];
    };
  };  

}
