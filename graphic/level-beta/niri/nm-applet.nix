{ lib, ... }:

{
  services.network-manager-applet.enable = true;

  systemd.user.services.network-manager-applet = {
    Install = {
      WantedBy = lib.mkForce [ "niri.service" ];
    };

    Unit = {
      PartOf = lib.mkForce [ "niri.service" ];
      After = lib.mkForce [ "niri.service" ];
    };
  };
}
