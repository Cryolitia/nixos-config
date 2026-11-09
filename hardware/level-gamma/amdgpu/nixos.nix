{ pkgs, ... }:
{
  hardware.amdgpu.opencl.enable = true;
  nixpkgs.config.rocmSupport = true;
  environment.systemPackages = [ pkgs.nvtopPackages.amd ];
}
