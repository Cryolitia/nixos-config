{ config, pkgs, ... }:

{

  programs.dconf.enable = true;

  #specialisation."Gnome".configuration = {
    imports = [
      ../../../graphic/desktop/gnome.nix
    ];
  #};

  #specialisation."GnomeNvidia".configuration = {
  #  imports = [
  #    ../../../graphic/desktop/gnome.nix
  #    ./nvidia.nix
  #  ];
  #};

  #specialisation."Hyprland".configuration = {
  #    imports = [
  #      ../../../graphic/desktop/hyprland.nix
  #    ];
  #};
}
