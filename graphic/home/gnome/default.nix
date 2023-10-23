{ lib, config, pkgs, osConfig, ... }:

let

  check = import ./check-dconf-sorted.nix { inherit lib; inherit config; };

in

assert check == "all good!";

lib.mkIf osConfig.services.xserver.desktopManager.gnome.enable {

  dconf.settings = import ./dconf.nix { inherit lib; inherit config; };

}
