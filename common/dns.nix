{ config, pkgs, pkgs-patch, ... }:

{
  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
        # If using dhcpcd:
    dhcpcd.extraConfig = "nohook resolv.conf";
        # If using NetworkManager:
    networkmanager.dns = "none";
  };

  services.resolved.enable = false;

  services.dnscrypt-proxy2 = {
    enable = true;
      settings = {
        # ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
            urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
            ];
            cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
            minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

      bootstrap_resolvers = ["1.1.1.1:53" "119.29.29.29:53" "223.5.5.5:53"];

      server_names = [
        "cloudflare"
        "google"
        #"dnspod"
        #"alidns-doh"
      ];

    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

}
