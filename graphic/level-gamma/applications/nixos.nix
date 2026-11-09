{ pkgs, ... }:

{
  # ./waydroid.nix
  # Optional Waydroid is controlled separately by features.waydroid.enable.

  environment.systemPackages = with pkgs; [
    # texlive.combined.scheme-full
    wpsoffice
    kdePackages.kleopatra
    keepassxc
    discord
    # lutris
    scrcpy
    element-desktop
    thunderbird
    qq
    vlc
  ];

  services.flatpak.enable = true;
}
