{ pkgs, ... }:

{
  fonts.packages = import ./packages.nix { inherit pkgs; };
}
