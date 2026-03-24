{ pkgs, ... }:
{

  environment.systemPackages = [ pkgs.swayosd ];

  services.dbus.packages = [ pkgs.swayosd ];

  services.udev.packages = [ pkgs.swayosd ];

  systemd.services.swayosd-input = {
    enable = true;
    description = pkgs.swayosd.meta.description;
    after = [ "graphical.target" ];

    unitConfig = {
      ConditionPathExists = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
      PartOf = [ "graphical.target" ];
    };

    serviceConfig = {
      User = "root";
      Type = "dbus";
      BusName = "org.erikreider.swayosd";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
      Restart = "on-failure";
    };

    wantedBy = [ "graphical.target" ];
  };

  systemd.user.services.swayosd-server = {
    enable = true;
    description = pkgs.swayosd.meta.description;
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
      Restart = "on-failure";
    };
  };
}
