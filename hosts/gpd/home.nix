{ lib, ... }:

{
  imports = [ ../../graphic/home ];

  programs.git.signing = {
    signByDefault = true;
    key = "3E5D1772FC8A8EDD";
  };

  programs.kitty.font.size = 12.0;

  dconf.settings = {
    "org/gnome/desktop/interface".text-scaling-factor = 1.0;

    "org/gnome/shell/extensions/freon".hot-sensors = lib.mkForce [
      "__max__"
      "in0"
      "PPT"
      "fan1"
    ];
  };
}
