# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ../../common
    ../../hardware
    ../../graphic/software
    ../../graphic/desktop/gnome.nix
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.supportedFilesystems = [ "ntfs" ];

  services.openssh.enable = true;

  nixpkgs.overlays = [
    (_: super: {
      zfs = super.zfs.overrideAttrs (_: {
        meta.platforms = [ ];
      });
    })
  ];

  services.pulseaudio.enable = lib.mkForce false;

  environment.sessionVariables.POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = "true";

  systemd.user.services.activate-linux.serviceConfig.ExecStart = lib.mkForce ''
    ${lib.getExe pkgs.activate-linux} -x 300 -y 80 -t "Activate NixOS" -m "Contact Cryolitia to activate NixOS"
  '';

  # For test https://github.com/NixOS/nixpkgs/pull/271342
  # hardware.cpu.amd.ryzen-smu.enable = true;
  # environment.systemPackages = [ pkgs.ryzenadj ];
}
