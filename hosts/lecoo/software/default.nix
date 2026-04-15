{ pkgs, ... }:

{
  imports = [
    ../../../graphic/software/high-performance.nix
    ../../../graphic/software/aagl.nix
    ../../../graphic/software/steam.nix
    ../../../common/software/transmission.nix
  ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.amd
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "11.0.3";
    environmentVariables = {
      OLLAMA_VULKAN = "1";
      ROCR_VISIBLE_DEVICES = "0";
      OLLAMA_GPU_OVERHEAD = "0";
    };
  };
}
