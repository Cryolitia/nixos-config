{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (import ./packages.nix { inherit pkgs; })
    ++ (with pkgs; [
      btrfs-progs
      usbutils
      pciutils
      lm_sensors
      smartmontools
      gdb
      udftools
      parted
      wiremix
      bluetui
      screen
      nix-tree
    ]);
}
