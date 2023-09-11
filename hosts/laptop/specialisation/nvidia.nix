{ config, pkgs, ... }:

{
  
  specialisation."NvidiaOpenDriver".configuration = {

    system.nixos.tags = [ "Nvidia-Open-Driver" ];
    
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {

        open = true;
        nvidiaSettings = true;
        powerManagement.enable = true;

    };

    environment.systemPackages = with pkgs.cudaPackages; [
      cudatoolkit
      cutensor
      cudnn
    ];

    nixpkgs.config.cudaSupport = true;

  };

}