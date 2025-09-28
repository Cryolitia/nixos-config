{ pkgs, ... }:

{
  services.qbittorrent = {
    enable = true;
    webuiPort = 8080;
    torrentingPort = 55555;
    profileDir = "/var/lib/data";
    serverConfig = {
      Core.AutoDeleteAddedTorrentFile = "Never";
      LegalNotice.Accepted = true;
      Preferences = {
        Connection.ResolvePeerCountries = true;
        WebUI = {
          Address = "*";
          AlternativeUIEnabled = true;
          AuthSubnetWhitelist = "127.0.0.0/8";
          AuthSubnetWhitelistEnabled = true;
          CSRFProtection = true;
          ClickjackingProtection = true;
          SecureCookie = true;
          SessionTimeout = 3600;
          UseUPnP = true;
          Username = "admin";
          Password_PBKDF2 = "@ByteArray(Z5LYf9hf54dMXJVuMSvlJQ==:JZaCXatfev4IxjXnRyCteNPtsD+Jj+lo9GdoFRV2Qe9rEp4VIKKILt31fKgItCrlevsjmL3sGIH1OCTRdMavhg==)";
          MaxAuthenticationFailCount = 5;
          Port = 8080;
          RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
        };
        General.Locale = "zh_CN";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    #8080
    55555
  ];
  me.cryolitia.services.nginx.internal."qbt" = 8080;
}
