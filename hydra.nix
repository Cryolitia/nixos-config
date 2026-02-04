#
# jobset example file. This file can be referenced as Nix expression
# in a jobset configuration along with inputs for nixpkgs and the
# repository containing this file.
#
{ ... }:
let
  # <nixpkgs> is set to the value designated by the nixpkgs input of the
  # jobset configuration.
  pkgs = (import <nixpkgs> { });
  output = builtins.getFlake (toString ./.);
in
{
  # linux_rpi5 = pkgs.linux_rpi4.override {
  #   rpiVersion = 5;
  #   argsOverride.defconfig = "bcm2712_defconfig";
  # };
  linux_q6a = output.outputs.packages."aarch64-linux".linux_q6a;
  linux_o6 =
    output.outputs.nixosConfigurations.cryolitia-radxa-o6-nixos.config.specialisation.vendor.configuration.boot.kernelPackages.kernel;
}
