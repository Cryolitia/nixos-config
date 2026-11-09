{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../profiles/level-beta/nixos.nix
    ../../hardware/level-beta/graphics/nixos.nix
    ../../hardware/level-gamma/nvidia/nixos.nix
    ../../services/level-alpha/podman/nixos.nix
    # ../../graphic/level-beta/niri/nixos.nix
  ];

  home-manager.users.cryolitia = ./home.nix;

  features.desktop = [ "gnome" ];

  boot.loader = {
    timeout = lib.mkDefault 5;
    systemd-boot.enable = true;
  };

  hardware.cix.sky1.enable = lib.mkForce false;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.enableEmergencyMode = true;

  networking.hostName = "cryolitia-radxa-o6-nixos";

  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  nix.extraOptions = ''
    extra-platforms = aarch64-linux
  '';

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  services.displayManager.gdm.autoSuspend = false;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    environmentVariables = {
      OLLAMA_VULKAN = "1";
    };
  };

  nixpkgs.config.cudaSupport = true;

  hardware.nvidia.prime.offload.enable = false;
  nixpkgs.overlays = [
    (_: prev: {
      # Keep Firefox's ONNX dependency compatible with the upstream binary cache.
      onnxruntime = prev.onnxruntime.override {
        cudaSupport = false;
        openvino = prev.openvino.override {
          opencv = prev.opencv.override { enableCuda = false; };
        };
      };
    })
  ];

  hardware.graphics.enable32Bit = lib.mkForce false;
}
