{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    netdata
  ];

  services.netdata.enable = true;
}