# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../profiles/level-gamma/nixos.nix
    ../../hardware/level-beta/bluetooth/nixos.nix
    ../../hardware/level-beta/graphics/nixos.nix
    ../../hardware/level-beta/tpm/nixos.nix
    ../../hardware/level-gamma/zen-kernel/nixos.nix
    ../../hardware/level-gamma/amdgpu/nixos.nix
    ../../services/level-gamma/binfmt/nixos.nix
    ../../graphic/level-beta/sunshine/nixos.nix
    ../../services/level-alpha/nix-serve/nixos.nix
  ];

  home-manager.users.cryolitia = ./home.nix;

  # features.desktop = [ "gnome" ];
  features.desktop = [ "niri" ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    edk2-uefi-shell.enable = true;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  boot.binfmt.emulatedSystems = [ "riscv64-linux" ];

  networking.hostName = "cryolitia-lecoo-minipro-nixos"; # Define your hostname.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  hardware.cpu.amd.ryzen-smu.enable = true;

  services.sunshine.autoStart = true;

  services.nix-serve = {
    openFirewall = true;
    port = 80;
  };
  systemd.services.nix-serve.serviceConfig.AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
}
