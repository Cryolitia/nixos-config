#
# jobset example file. This file can be referenced as Nix expression
# in a jobset configuration along with inputs for nixpkgs and the
# repository containing this file.
#
{ ... }:
let
  # <nixpkgs> is set to the value designated by the nixpkgs input of the
  # jobset configuration.
  # pkgs = (import <nixpkgs> { });
  output = builtins.getFlake (toString ./.);
in
{
  radxa-linux-qcom = output.outputs.packages."aarch64-linux".radxa-linux-qcom;
  linux-o6 =
    output.outputs.nixosConfigurations.cryolitia-radxa-o6-nixos.config.specialisation.vendor.configuration.boot.kernelPackages.kernel;
}
