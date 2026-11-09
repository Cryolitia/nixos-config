# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../profiles/level-gamma/nixos.nix
    ../../hardware/level-beta/graphics/nixos.nix
    ../../hardware/level-beta/tpm/nixos.nix
    ../../hardware/level-gamma/zen-kernel/nixos.nix
    ../../hardware/level-gamma/amdgpu/nixos.nix
    ../../services/level-gamma/binfmt/nixos.nix
    ./software
    ./specialisation
  ];

  home-manager.users.cryolitia = ./home.nix;

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    edk2-uefi-shell.enable = true;
    windows."11".efiDeviceHandle = "FS0";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cryolitia-gpd-wm2-nixos"; # Define your hostname.

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];

  services.displayManager.sddm.settings.General.GreeterEnvironment =
    "QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192";

  hardware.cpu.amd.ryzen-smu.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="ADP1", ATTR{online}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
    SUBSYSTEM=="power_supply", KERNEL=="ADP1", ATTR{online}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"

    # GPD
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2f24", ATTRS{idProduct}=="0135", MODE="0666", GROUP="plugdev"
  '';

  hardware.gpd-fan.enable = true;

  hardware.xone.enable = true;
  hardware.xpad-noone.enable = true;

  hardware.sensor.iio.enable = true;

  hardware.bluetooth.enable = true;
}
