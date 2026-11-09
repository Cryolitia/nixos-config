{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.kitty ];
  home-manager.users.cryolitia = import ./hm.nix;
}
