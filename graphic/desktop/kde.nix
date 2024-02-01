{ ... }:

{
  imports = [
    ./sddm.nix
  ];

  system.nixos.tags = [ "KDE" ];

  services.xserver = {
    desktopManager.plasma5.enable = true;
  };

  services.xserver.displayManager.defaultSession = "plasmawayland";

}
