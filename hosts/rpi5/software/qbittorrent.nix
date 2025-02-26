{ pkgs, ... }:

{

  systemd.services.qbittorrent = {
    after = [ "network.target" ];
    description = "qBittorrent Daemon";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.qbittorrent-nox ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.qbittorrent-nox}/bin/qbittorrent-nox \
          --profile="/mnt/NAS/Data/" \
          --torrenting-port=55555
      '';
      # To prevent "Quit & shutdown daemon" from working; we want systemd to
      # manage it!
      Restart = "on-success";
      User = "qbittorrent";
      Group = "qbittorrent";
      UMask = "0002";
    };
  };

  users.users.qbittorrent = {
    group = "qbittorrent";
    home = "/var/lib/qbittorrent";
    createHome = true;
    description = "qBittorrent Daemon user";
    isSystemUser = true;
  };

  users.groups.qbittorrent = {
    gid = null;
  };

  networking.firewall.allowedTCPPorts = [
    8080
    55555
  ];
}
