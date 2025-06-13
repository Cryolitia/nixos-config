{ pkgs, ... }:

{
  imports = [
    ../../../common/software
    ../../../common/software/netdata.nix
    ./homeassistant.nix
    ./syncthing.nix
    ./samba.nix
    ./qbittorrent.nix
    ./hydra.nix
    ./vlmcsd.nix
    ./wavelog.nix
    ./rsnapshot.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gphotos-sync
    libraspberrypi
    raspberrypi-eeprom
  ];
}
