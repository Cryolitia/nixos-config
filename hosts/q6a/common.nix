{
  pkgs,
  config,
  ...
}:
let
  aic8800-firmware = pkgs.callPackage ./aic8800-firmware.nix { };
in
{
  boot = {
    kernelPackages = pkgs.linuxPackagesFor (import ./kernel.nix { inherit pkgs; });
    loader = {
      systemd-boot = {
        enable = true;
        installDeviceTree = true;
        edk2-uefi-shell.enable = true;
      };
      efi.canTouchEfiVariables = false;
    };
    kernelParams = [
      "console=ttyMSM0,115200n8"
      "earlycon"
      "keep_bootcon"
    ];

    initrd = {
      availableKernelModules = [
        "usb_storage"
        "nvme"
        "xhci_hcd"
      ];
    };

    extraModulePackages = [
      ((config.boot.kernelPackages.callPackage ./aic8800.nix { }).usb)
    ];

    kernelModules = [
      "aic8800_fdrv"
      "aic_load_fw"
    ];
  };

  console.earlySetup = true;

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

  environment.systemPackages = with pkgs; [
    fastfetch
  ];

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
}
