{ config, pkgs, pkgs-patch, ... }:

{

  environment.systemPackages = (with pkgs.python310Packages; [
    pytorch-bin
    venvShellHook
    numpy
    pillow
    matplotlib
    torchvision-bin
  ]) ++ (with pkgs; [
    python310
    virtualenv
  ]);
}