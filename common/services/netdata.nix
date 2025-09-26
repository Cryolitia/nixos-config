{ pkgs, ... }:

{
  services.netdata = {
    enable = true;
    package = pkgs.netdata.override { withCloudUi = true; };
  };

  me.cryolitia.services.nginx.external."netdata" = 19999;
}
