{ config, pkgs, ... }:

{
  imports =
    [
      ./syncthing.nix
      ../../../graphic/software/high-performance.nix
      ./develop
      # ./hadoop.nix
    ];
}
