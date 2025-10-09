{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ../../../common/software
    ../../../common/services/netdata.nix
    ../../../common/services/hydra.nix
    ./homeassistant.nix
    ./syncthing.nix
    ./samba.nix
    ./qbittorrent.nix
    ./vlmcsd.nix
    ./wavelog.nix
    ./rsnapshot.nix
    ./gatus.nix
    ./code-server.nix
    ./dashy.nix
    ./bind.nix
    ./smartdns.nix
  ];

  services.nginx.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #gphotos-sync
  ];

  services.iperf3 = {
    enable = true;
    openFirewall = true;
  };

  services.nginx.virtualHosts."${config.services.dashy.virtualHost.domain}" = {
    listenAddresses = [
      "0.0.0.0"
      "[::]"
    ];
    locations."/" = {
      extraConfig = ''
        allow 127.0.0.1;
        allow ::1;
        allow 192.168.0.0/16;
        allow fd00::/7;
        deny all;
      '';
    };
    locations."= /whoami" = {
      return = "200 \"$remote_addr\"";
      extraConfig = ''
        default_type text/plain;
      '';
    };
  };

  me.cryolitia.services.nginx.internal."sdr" = 8073;
  services.nginx.virtualHosts."sdr.*".locations."/".proxyPass =
    lib.mkForce "http://q6a.internal:8073";
}
