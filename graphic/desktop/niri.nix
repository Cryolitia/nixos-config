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

  security.pam.services.hyprlock = { };
}
