{ config, pkgs, ... }:

{
  imports = [
    ./nvidia.nix
    ./nonvdia.nix
  ];
}