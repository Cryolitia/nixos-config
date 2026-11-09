{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.btop ];
  hjem.users.cryolitia.imports = [ ./hjem.nix ];
}
