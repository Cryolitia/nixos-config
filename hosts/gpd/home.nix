{ config, pkgs, lib, ... }:

{

  imports = [
    ../../graphic/home
  ];

  programs.git.signing = {
    signByDefault = true;
    key = "3E5D1772FC8A8EDD";
  };

  home.file.".config/maa".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/maa";

  home.file."Documents/template.tex".source = ../../dotfiles/template.tex;

  programs.kitty.font.size = 16.0;

  dconf.settings = {
    "org/gnome/desktop/interface".text-scaling-factor = 1.5;

    "org/gnome/shell/extensions/freon".hot-sensors = lib.mkForce [
      "__max__"
      "in0"
      "Composite"
      "PPT"
    ];
  };
}
