{ pkgs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hardware
    ./software
    ../../common
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

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
    device = "/dev/disk/by-uuid/cd1d85fa-f4f7-4d16-898c-0231b324401d";
    fsType = "btrfs";
    options = [ "space_cache=v2" ];
  };

  nix.extraOptions = ''
    extra-platforms = aarch64-linux
  '';

  boot.kernelPatches = [
    {
      name = "Disable DEBUG_INFO and DRM";
      patch = null;
      extraConfig = ''
        DEBUG_INFO n
        DEBUG_KERNEL n
        DEBUG_INFO_NONE y
        DRM n
      '';
    }
  ];

  # environment.noXlibs = true;
}
