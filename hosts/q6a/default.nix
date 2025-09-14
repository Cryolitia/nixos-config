{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    # ./hardware-configuration.nix
    ../../common
    ../../hardware/sound.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackagesFor (import ./kernel.nix { inherit pkgs inputs; });
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
      timeout = 5;
    };
    kernelParams = [
      "console=ttyMSM0,115200n8"
      "earlycon"
      "keep_bootcon"
      "systemd.setenv=SYSTEMD_SULOGIN_FORCE=1"
    ];

    initrd.systemd.emergencyAccess = true;
  };

  hardware = {
    firmware = with pkgs; [
      linux-firmware
    ];
    deviceTree = {
      enable = true;
      name = "qcom/qcs6490-radxa-dragon-q6a.dtb";
    };
  };

  networking.hostName = "q6a-nixos";

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
}
