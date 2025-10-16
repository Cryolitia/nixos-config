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
    ./font.nix
    ./activate-linux.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (import ./vscode.nix {
      inherit pkgs inputs;
    })

    firefox
    gparted
    nixd
    nixpkgs-fmt
    kitty
    nordic
    arc-theme
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    libnotify
    mission-center
  ];

  services.gnome.gnome-keyring.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];

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
