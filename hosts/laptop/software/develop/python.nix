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
    (opencv4.override {
        enablePython = true;
        pythonPackages = pkgs.python310Packages;
        enableGtk2 = true;
        enableGtk3 = true;
      })
  ]) ++ (with pkgs; [
    python310
  ]) ++ (with pkgs.cudaPackages; [
    cuda_cudart
    cuda_nvcc
  ]);
}
