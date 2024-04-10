# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common
      ../../hardware
      ../../graphic/software
      # ../../graphic/software/waydroid.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cryolitia-surface"; # Define your hostname.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  specialisation = {
    "Gnome".configuration = {
      imports = [
        ../../graphic/desktop/gnome.nix
      ];
    };
    "Hyprland".configuration = {
      imports = [
        ../../graphic/desktop/hyprland.nix
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    wpsoffice
  ];

}
