{ pkgs, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    firefox
    gparted
    nordic
    qt5.qtwayland
    qt6.qtwayland
    libnotify
    mission-center
    nautilus
    crosspipe
    telegram-desktop
    kdePackages.okular
    mpv
    moonlight-qt
  ];

  services.gnome.gnome-keyring.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];

  home-manager.users.cryolitia = import ./hm.nix;
}
