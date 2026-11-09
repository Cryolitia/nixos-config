{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.btop ];
  home-manager.users.cryolitia.imports = [ ./hm.nix ];
}
