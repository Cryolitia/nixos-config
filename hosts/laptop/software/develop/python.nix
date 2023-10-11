{ config, pkgs, pkgs-patch, ... }:

{

  imports = [
    ./develop
  ]

  environment.systemPackages = (with pkgs.python310Packages; [
    pytorch-bin
    venvShellHook
    numpy
    pillow
    matplotlib
    torchvision-bin
    requests
  ]) ++ (with pkgs; [
    python310
    virtualenv
  ]);
}