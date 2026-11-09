{ lib, ... }:

{
  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = ../../../resources/profile-beta/background;
        duration = "30m";
        sorting = "random";
      };
    };
  };

  systemd.user.services.wpaperd = {
    Install = {
      WantedBy = lib.mkForce [ "niri.service" ];
    };

    Unit = {
      PartOf = lib.mkForce [ "niri.service" ];
      After = lib.mkForce [ "niri.service" ];
    };
  };
}
