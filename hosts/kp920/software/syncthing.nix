{ ... }:

{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    overrideDevices = false;
    openDefaultPorts = true;
    settings.folders = {
      "/var/Book" = {
        label = "Book";
        id = "dj23u-m3zg9";
      };
      "/var/Music" = {
        label = "Music";
        id = "jtqwy-n7gue";
      };
      "/var/Archive" = {
        label = "Archive";
        id = "2jnxm-wvfvd";
      };
    };
  };
}
