{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  # https://github.com/HimDek/Utterly-Nord-Plasma/pull/29
  patchedUtterlyNordPlasma = pkgs.utterly-nord-plasma.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      (pkgs.fetchpatch {
        url = "https://github.com/HimDek/Utterly-Nord-Plasma/commit/3000c9451bb7ed7e7fbbe1d381ae21bdb714c6ee.patch";
        hash = "sha256-G5w7hOjjt6PF6uayp9ebLLcyduxHg9Vltc+2u2n/dFg=";
      })
    ];
  });
in

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

      patchedUtterlyNordPlasma
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
        theme = "${patchedUtterlyNordPlasma}/share/sddm/themes/Utterly-Nord";
        extraPackages = patchedUtterlyNordPlasma.propagatedBuildInputs;
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
