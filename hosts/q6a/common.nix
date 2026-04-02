{
  pkgs,
  lib,
  config,
  ...
}:
let
  aic8800-firmware = pkgs.callPackage ./aic8800-firmware.nix { };

  patchesFromDir =
    patchDir:
    let
      dirEntries = builtins.readDir patchDir;
      patchFiles = builtins.sort builtins.lessThan (
        builtins.filter (
          name: dirEntries.${name} == "regular" && builtins.match ".*\\.patch" name != null
        ) (builtins.attrNames dirEntries)
      );
    in
    map (name: {
      name = lib.removeSuffix ".patch" name;
      patch = patchDir + "/${name}";
    }) patchFiles;
in
{
  config = {
    assertions = [
      {
        assertion = lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.19";
        message = "The Radxa Q6A requires Linux 6.19 or above";
      }
    ];

    boot = {
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      kernelPatches = (patchesFromDir ./patches) ++ [
        {
          name = "enable-config";
          patch = null;
          extraConfig = ''
            RPMB y
            SCSI_UFSHCD y
            SCSI_UFSHCD_PLATFORM y
            SCSI_UFS_QCOM y
          '';
        }
      ];
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

    systemd.tpm2.enable = false;
  };
}
