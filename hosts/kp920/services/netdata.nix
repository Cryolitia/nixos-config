{ pkgs, ... }:

{
  services.netdata = {
    enable = true;
    package = pkgs.netdata.override { withCloudUi = true; };
  };

  me.cryolitia.services.nginx.external."netdata" = {
    port = 19999;
  };
}
