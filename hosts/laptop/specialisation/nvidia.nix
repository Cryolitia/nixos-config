{ config, pkgs, ... }:

{

    system.nixos.tags = [ "Nvidia" ];
    
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



}