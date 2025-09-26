{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ../../common/software
    ./chrome.nix
    ../../hardware/yubikey.nix
    ./font.nix
    ./activate-linux.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (import ./vscode.nix {
      inherit pkgs inputs;
    })

    gparted
    telegram-desktop
    #go-musicfox
    nixd
    nixpkgs-fmt
    kdePackages.okular
    hugo
    kitty
    nordic
    arc-theme
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    qq
    mpv
    vlc
    # blackbox-terminal
    libnotify
    mission-center
    typst
    tinymist
    nur-cryolitia.get-lrc
  ];

  programs.kdeconnect.enable = true;
  services.gnome.gnome-keyring.enable = true;

  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
    serviceMode = true;
  };

  services.xserver.excludePackages = [ pkgs.xterm ];

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    config = lib.mkDefault {
      common = {
        default = lib.mkDefault [
          "gtk"
        ];
      };
    };
  };
}
