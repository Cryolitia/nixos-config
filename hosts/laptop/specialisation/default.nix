{ config, pkgs, ... }:

{

  programs.dconf.enable = true;

  specialisation."GnomeNvidia".configuration = {
      imports = [
        ./nvidia.nix
        ../../../graphic/desktop/gnome.nix
      ];
  };

  specialisation."GnomeNoNvidia".configuration = {
      imports = [
        ./nonvidia.nix
        ../../../graphic/desktop/gnome.nix
      ];
  };

  specialisation."KDENvidia".configuration = {
      imports = [
        ./nvidia.nix
        ../../../graphic/desktop/kde.nix
      ];
  };

  specialisation."KDENoNvidia".configuration = {
      imports = [
        ./nonvidia.nix
        ../../../graphic/desktop/kde.nix
      ];
  };

}