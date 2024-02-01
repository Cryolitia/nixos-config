{ ... }:

{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    configDir = "/mnt/NAS/Data/syncthing";
    overrideDevices = false;
    openDefaultPorts = true;
    settings.folders = {
      "/mnt/NAS/Book" = {
        label = "Book";
        id = "dj23u-m3zg9";
      };
      "/mnt/NAS/Music" = {
        label = "Music";
        id = "jtqwy-n7gue";
      };
      "/mnt/NAS/Archive" = {
        label = "Archive";
        id = "2jnxm-wvfvd";
      };
      "/mnt/NAS/Software" = {
        label = "Windows-Software";
        id = "qwgkm-3m9tg";
      };
    };
  };
}
