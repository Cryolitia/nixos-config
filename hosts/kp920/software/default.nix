{
  pkgs,
  lib,
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

  me.cryolitia.services.nginx.internal."sdr" = 8073;
  services.nginx.virtualHosts."sdr.*".locations."/".proxyPass =
    lib.mkForce "http://q6a.internal:8073";
}
