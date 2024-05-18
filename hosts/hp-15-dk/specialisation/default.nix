{ ... }:

{

  programs.dconf.enable = true;

  specialisation."GnomeNvidia".configuration = {
    imports = [
      ./nvidia.nix
      ../../../graphic/desktop/gnome.nix
    ];
  };

  #specialisation."GnomeNoNvidia".configuration = {
  #    imports = [
  #      ./nonvidia.nix
  #      ../../../graphic/desktop/gnome.nix
  #    ];
  #};

  #specialisation."HyprlandNoNvidia".configuration = {
  #    imports = [
  #      ./nonvidia.nix
  #      ../../../graphic/desktop/hyprland.nix
  #    ];
  #};
}
