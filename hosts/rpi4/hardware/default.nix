{ config, pkgs, ... }:

{
  imports =
    [
      ./bluetooth.nix
      ./ap.nix
    ];
}