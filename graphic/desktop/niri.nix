{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../software/fcitx5.nix
    ../software/swayosd.nix
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri = {
    enable = true;
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
  ];

  system.nixos.tags = [ "Niri" ];

  services = {
    xserver = {
      enable = true;
      xkb.layout = "cn";
      xkb.variant = "";
      excludePackages = [ pkgs.xterm ];
    };
    # https://github.com/nixos/nixpkgs/issues/523332
    displayManager.gdm.enable = false;
    displayManager.sddm = {
      enable = lib.mkDefault true;
      theme = "${pkgs.utterly-nord-plasma}/share/sddm/themes/Utterly-Nord";
      extraPackages = pkgs.utterly-nord-plasma.propagatedBuildInputs;
      wayland.enable = true;
      enableHidpi = true;
    };
  };

  security.pam.services.hyprlock = { };

  programs.dconf.enable = true;
}
