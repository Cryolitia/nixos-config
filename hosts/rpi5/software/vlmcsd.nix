{ pkgs, ... }:

{
  systemd.services.vlmcsd = {
    after = [ "network.target" ];
    description = "vlmcsd";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.nur.repos.pborzenkov.vlmcsd ];
    serviceConfig = {
      ExecStart = "${pkgs.nur.repos.pborzenkov.vlmcsd}/bin/vlmcsd -D -v";
      DynamicUser = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 1134 ];
}
