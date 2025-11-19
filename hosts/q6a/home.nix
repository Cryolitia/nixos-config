{ lib, ... }:

{
  imports = [
    ../../common/home.nix
    ../../graphic/home
    ../../graphic/home/niri
  ];

  programs.niri.settings.input.mod-key = "Alt";

  programs.waybar.settings.mainBar.clock = {
    interval = 1;
    format = lib.mkForce "{:%FT%T%z}";
  };
}
