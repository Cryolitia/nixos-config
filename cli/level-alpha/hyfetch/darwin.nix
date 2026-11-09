{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.hyfetch ];
  home-manager.users.cryolitia.imports = [ ./hm.nix ];
}
