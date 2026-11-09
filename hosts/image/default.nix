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
    ../../profiles/level-beta/nixos.nix
    ../../hardware/level-beta/graphics/nixos.nix
    ../../hardware/level-beta/tpm/nixos.nix
    # ../../graphic/level-beta/niri/nixos.nix
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
  ];

  home-manager.users.cryolitia = ./home.nix;

  features.desktop = [ "gnome" ];

  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  boot.supportedFilesystems = {
    ntfs = true;
    zfs = lib.mkForce false;
  };

  services.pulseaudio.enable = lib.mkForce false;

  environment.sessionVariables.POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = "true";

  systemd.user.services.activate-linux.serviceConfig.ExecStart = lib.mkForce ''
    ${lib.getExe pkgs.activate-linux} -x 400 -y 80 -t "Activate NixOS" -m "Evaluation Copy. Build ${lib.version}" -f "Sarasa Mono SC"
  '';

  # For test https://github.com/NixOS/nixpkgs/pull/271342
  # hardware.cpu.amd.ryzen-smu.enable = true;
  # environment.systemPackages = [ pkgs.ryzenadj ];
}
