{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.hyfetch ];
  hjem.users.cryolitia.imports = [ ./hjem.nix ];
}
