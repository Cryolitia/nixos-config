{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nur.repos.pborzenkov.vlmcsd
  ];
  
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
  
}