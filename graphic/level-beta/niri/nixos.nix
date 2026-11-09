{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  config = lib.mkIf (lib.elem "niri" config.features.desktop) {

    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    programs.niri = {
      package = pkgs.niri-stable;
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      libsecret
      gamescope
      xwayland-satellite-stable
      clipse
      fuzzel
      playerctl
      wl-mirror

      utterly-nord-plasma
      swayosd
    ];

    system.nixos.tags = [ "Niri" ];

    services = {
      xserver = {
        enable = true;
        xkb.layout = "cn";
        xkb.variant = "";
        excludePackages = [ pkgs.xterm ];
      };
      displayManager.sddm = lib.mkIf (!(lib.elem "gnome" config.features.desktop)) {
        theme = "${pkgs.utterly-nord-plasma}/share/sddm/themes/Utterly-Nord";
        extraPackages = pkgs.utterly-nord-plasma.propagatedBuildInputs;
        wayland.enable = true;
        enableHidpi = true;
      };
    };

    security.pam.services.hyprlock = { };

    programs.dconf.enable = true;

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
      wantedBy = [ "niri.service" ];
      after = [ "niri.service" ];
      partOf = [ "niri.service" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
        Restart = "on-failure";
      };
    };

    home-manager.users.cryolitia = import ./hm.nix;
  };
}
