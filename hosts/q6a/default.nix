{
  pkgs,
  config,
  inputs,
  ...
}:
let
  aic8800-firmware = pkgs.callPackage ./aic8800-firmware.nix { };
in
{
  imports = [
    # Include the results of the hardware scan.
    # ./hardware-configuration.nix
    ../../common
    ../../hardware/sound.nix
    ./hardware-configuration.nix
    ./owrx.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackagesFor (import ./kernel.nix { inherit pkgs; });
    loader = {
      systemd-boot = {
        # enable = true;
        installDeviceTree = true;
        edk2-uefi-shell.enable = true;
      };
      grub = {
        enable = true;
        device = "/dev/disk/by-label/ESP";
      };
      efi.canTouchEfiVariables = false;
      timeout = 5;
    };
    kernelParams = [
      "console=ttyMSM0,115200n8"
      "earlycon"
      "keep_bootcon"
      "systemd.setenv=SYSTEMD_SULOGIN_FORCE=1"
      "loglevel=8"
    ];

    initrd = {
      availableKernelModules = [
        "usb_storage"
        "nvme"
        "xhci_hcd"
      ];
    };
  };

  console.earlySetup = true;

  networking.firewall.allowedTCPPorts = [ 8073 ];

  systemd.enableEmergencyMode = true;

  hardware = {
    firmware = with pkgs; [
      linux-firmware
      aic8800-firmware
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

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  virtualisation.podman.enable = true;

  boot.extraModulePackages = [
    ((config.boot.kernelPackages.callPackage ./aic8800.nix { }).usb)
  ];

  boot.kernelModules = [
    "aic8800_fdrv"
    "aic_load_fw"
  ];
}
