{ config, lib, ... }:
let
  gnome = lib.elem "gnome" config.features.desktop;
  niri = lib.elem "niri" config.features.desktop;
in
{
  imports = [
    (import ../options.nix { inherit lib; }).desktop
    ../gnome/nixos.nix
    ../niri/nixos.nix
  ];

  services.desktopManager.gnome.enable = gnome;
  programs.niri.enable = niri;

  # https://github.com/nixos/nixpkgs/issues/523332
  # Niri alone retains its SDDM setup; GNOME provides GDM when both are selected.
  services.displayManager.gdm.enable = gnome;
  services.displayManager.sddm.enable = niri && !gnome;
}
