# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, tpm-patch, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common
      ../../hardware
      ./software
      ./specialisation
    ];

      # Bootloader.
    boot.loader.systemd-boot = {
        enable = true;
        consoleMode = "2";
    };
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_zen;

    boot.supportedFilesystems = [ "ntfs" ];

    networking.hostName = "Cryolitia-nixos"; # Define your hostname.

    fileSystems."/mnt/Data" = {
      device="/dev/disk/by-uuid/b7b5e345-1b1c-4203-920e-d7e4680c4a69";
      fsType="btrfs";
  };

    services.logind.lidSwitchExternalPower = "lock";

    services.openssh.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
    };
}