{ pkgs, ... }:
{
  environment.systemPackages = [ (import ./package.nix { inherit pkgs; }) ];
}
