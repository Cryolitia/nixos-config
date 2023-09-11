{ config, pkgs, ... }:

{
    services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "end0";
      WIFI_IFACE = "wlan0";
      SSID = "Cryolitia_IoT";
      PASSPHRASE = "Na3AlF6210";
    };
  };
}