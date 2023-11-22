{ config, pkgs, pkgs-patch, ... }:

{
  environment.systemPackages = (with pkgs.python310Packages; [
    pytorch-bin
    venvShellHook
    numpy
    matplotlib
    torchvision-bin
    requests
    virtualenv
  ]) ++ (with pkgs; [
    python310
  ]) ++ (with pkgs.cudaPackages; [
    cuda_cudart
    cuda_nvcc
  ]);
}
