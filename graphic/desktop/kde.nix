{ config, pkgs, ... }:

{

  system.nixos.tags = [ "KDE" ];

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  services.xserver.displayManager.defaultSession = "plasmawayland";

}