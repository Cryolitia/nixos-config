{ pkgs, inputs, ... }:
{

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
  ];

  system.nixos.tags = [ "Niri" ];

  services = {
    xserver = {
      enable = true;
      xkb.layout = "cn";
      xkb.variant = "";
      excludePackages = [ pkgs.xterm ];
    };
    displayManager.gdm.enable = true;
  };

  imports = [
    ../software/fcitx5.nix
  ];

  security.pam.services.hyprlock = { };
}
