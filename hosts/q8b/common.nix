{
  pkgs,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackagesFor (import ../../common/radxa-linux-qcom.nix { inherit pkgs; });
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
      "clk_ignore_unused"
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

  hardware = {
    firmware = with pkgs; [
      linux-firmware
    ];
    deviceTree = {
      enable = true;
      name = "qcom/sc8280xp-radxa-dragon-q8b.dtb";
    };
  };

  environment.systemPackages = with pkgs; [
    fastfetch
  ];

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;
}
