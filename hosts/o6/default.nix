{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../common
    ../../hardware/sound.nix
    ../../graphic/desktop/niri.nix
    ../../graphic/desktop/gnome.nix
    ../../graphic/software
    (
      { lib, config, ... }:
      {
        config = lib.mkIf (config.specialisation != { }) {
          hardware.cix.sky1.bspRelease = "none";
          boot.kernelPackages = pkgs.linuxPackages_latest;
        };
      }
    )
  ];

  boot.loader = {
    timeout = lib.mkDefault 5;
    systemd-boot.enable = true;
  };

  systemd.enableEmergencyMode = true;

  networking.hostName = "o6-nixos";

  services.openssh.enable = true;

  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  nix.extraOptions = ''
    extra-platforms = aarch64-linux
  '';

  virtualisation.podman.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  specialisation = {
    vendor.configuration = {
      # Use CIX vendor kernel
    };
  };

  services.displayManager.gdm.autoSuspend = false;
}
