{ lib, pkgs, ... }:

{
  services.transmission = {
    enable = true;
    openFirewall = true;
    package = pkgs.transmission_4;
  };
  systemd.services.transmission.wantedBy = lib.mkForce [ ];
}
