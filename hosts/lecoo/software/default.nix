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
    package = pkgs.ollama-vulkan;
  };
}
