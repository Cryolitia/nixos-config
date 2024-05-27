# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:
let

  ryzen_smu = config.boot.kernelPackages.callPackage ./software/ryzen_smu.nix { };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../common
    ../../hardware
    ./software
    ./specialisation
  ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "cryolitia-gpd-nixos"; # Define your hostname.

  #fileSystems."/mnt/Data" = {
  #  device = "/dev/disk/by-uuid/c8388a09-ca0a-43a9-b92a-fe9e83f8fc90";
  #  fsType = "btrfs";
  #};

  services.logind.lidSwitchExternalPower = "lock";

  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  services.displayManager.sddm.settings.General.GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192";

  # hardware.cpu.amd.ryzen_smu.enable = true;
  # programs.ryzen_monitor_ng.enable = true;

  hardware.cpu.amd.ryzen-smu.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="ADP1", ATTR{online}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
    SUBSYSTEM=="power_supply", KERNEL=="ADP1", ATTR{online}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"

    SUBSYSTEM=="usb", ATTRS{idVendor}=="2f24", ATTRS{idProduct}=="0135", MODE="0666", GROUP="plugdev"
  '';

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "kitty.desktop" ];
  };

  hardware.gpd-fan.enable = true;

  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = false;
  };

  services.nixseparatedebuginfod.enable = true;
}
