{
  pkgs,
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
    distrobox
  ];

  services.iperf3 = {
    enable = true;
    openFirewall = true;
  };

  me.cryolitia.services.nginx.internal."sdr" = {
    address = "http://q6a.internal";
    port = 8073;
  };

  me.cryolitia.services.nginx.internal."linkr" = {
    address = "http://linkr.internal";
    port = 80;
    forceSSL = true;
  };
}
