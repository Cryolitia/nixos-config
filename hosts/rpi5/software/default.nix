{ pkgs, ... }:

{
  imports = [
    ../../../common/software
    ./homeassistant.nix
    ./syncthing.nix
    ./samba.nix
    ./qbittorrent.nix
    ../../../common/software/netdata.nix
    ./vlmcsd.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    libraspberrypi
    gphotos-sync
    raspberrypi-eeprom
  ];
}
