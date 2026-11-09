{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixos-hardware.nixosModules.common-gpu-nvidia ];

  hardware.nvidia.open = true;
  environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
}
