{ ... }:

{
  services.syncthing = {
    enable = true;
    guiAddress = "127.0.0.1:8384";
    overrideDevices = false;
    openDefaultPorts = true;
    settings.folders = {
      "/mnt/Data/Book" = {
        label = "Book";
        id = "dj23u-m3zg9";
      };
      "/mnt/Data/Music" = {
        label = "Music";
        id = "jtqwy-n7gue";
      };
      "/mnt/Data/Archive" = {
        label = "Archive";
        id = "2jnxm-wvfvd";
      };
    };
  };
}
