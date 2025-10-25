{ ... }:

{
  imports = [
    ../../common/home.nix
    ../../graphic/home
    ../../graphic/home/niri
  ];

  programs.niri.settings.input.mod-key = "Alt";
}
