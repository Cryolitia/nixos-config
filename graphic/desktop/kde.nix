{ ... }:

{
  imports = [
    ./sddm.nix
    ../software/fcitx5.nix
  ];

  system.nixos.tags = [ "KDE" ];

  services.desktopManager = {
    plasma6.enable = true;
    #plasma5.enable = true;
  };

  # services.xserver.displayManager.defaultSession = "plasmawayland";
}
