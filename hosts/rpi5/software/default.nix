{ pkgs, ... }:

{
  imports = [
    ../../../common/software
    ../../../common/services/netdata.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gphotos-sync
    libraspberrypi
    raspberrypi-eeprom
  ];
}
