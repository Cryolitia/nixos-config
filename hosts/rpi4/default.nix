{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware
      ./software
      ../../common
    ];

    networking.hostName = "rpi-nixos";

    services.openssh.enable = true;

    networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?

    fileSystems."/mnt/NAS" = {
        device="/dev/disk/by-uuid/cd1d85fa-f4f7-4d16-898c-0231b324401d";
        fsType="btrfs";
    };

    nix.extraOptions = ''
      extra-platforms = aarch64-linux
    '';

}