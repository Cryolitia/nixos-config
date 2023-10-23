{ config, pkgs, ... }:
let 
  
  cuda = import ../../../common/software/cuda.nix { inherit pkgs; };

in {

    system.nixos.tags = [ "Nvidia" ];
    
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {

        open = true;
        nvidiaSettings = true;
        powerManagement.enable = true;

    };

    environment.systemPackages = with pkgs.cudaPackages; [
      cuda.cuda-redist
      cuda.cuda-native-redist
      cutensor
      cudnn
      pkgs.nur-cryolitia.MaaAssistantArknights-beta-cuda-bin
    ];

    nixpkgs.config.cudaSupport = true;

    virtualisation.docker.enableNvidia = true;

}