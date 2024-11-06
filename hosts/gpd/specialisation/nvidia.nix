{ ... }:
let
in
{

  system.nixos.tags = [ "Nvidia" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
  };

  hardware.nvidia-container-toolkit.enable = true;
}
