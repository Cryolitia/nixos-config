{ lib, ... }:

{
  services.transmission = {
    enable = true;
    openFirewall = true;
  };
  systemd.services.transmission.wantedBy = lib.mkForce [ ];
}
