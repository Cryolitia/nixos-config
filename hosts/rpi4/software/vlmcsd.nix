{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    config.nur.repos.pborzenkov.vlmcsd
  ];
  
  systemd.services.vlmcsd = {
      after = [ "network.target" ];
      description = "vlmcsd";
      wantedBy = [ "multi-user.target" ];
      path = [ config.nur.repos.pborzenkov.vlmcsd ];
      serviceConfig = {
        ExecStart = "${config.nur.repos.pborzenkov.vlmcsd}/bin/vlmcsd -D -v";
        DynamicUser = true;
      };
  };
  
}
