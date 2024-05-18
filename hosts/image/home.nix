{ lib, ... }:

{

  imports = [ ../../graphic/home ];

  programs.git.signing = {
    signByDefault = true;
    key = "63982609A2647D3C";
  };

  wayland.windowManager.hyprland.settings.monitor = lib.mkForce ",preferred,auto,1";
}
