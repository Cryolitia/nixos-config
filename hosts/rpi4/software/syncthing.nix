{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    configDir = "/mnt/NAS/Data/syncthing";
    settings.folders = {
      "/mnt/NAS/Book" = {
        label = "Book";
        id = "dj23u-m3zg9";
      };
      "/mnt/NAS/Music" = {
        label = "Music";
        id = "jtqwy-n7gue";
      };
    };
  };
}