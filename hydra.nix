#
# jobset example file. This file can be referenced as Nix expression
# in a jobset configuration along with inputs for nixpkgs and the
# repository containing this file.
#
{ ... }:
let
  # <nixpkgs> is set to the value designated by the nixpkgs input of the
  # jobset configuration.
  pkgs = (import <nixpkgs> {});
in {
  linux_rpi5 = pkgs.linux_rpi4.override {
    rpiVersion = 5;
    argsOverride.defconfig = "bcm2712_defconfig";
  };
}
