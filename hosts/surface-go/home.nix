{ lib, ... }:

{

  imports = [ ../../graphic/home ];

  programs.git.signing = {
    signByDefault = true;
    key = "204B13F27C638936";
  };

  wayland.windowManager.hyprland.settings.monitor = lib.mkForce ",preferred,auto,1";
}
