{
  pkgs,
  config,
  ...
}:
let
  aic8800-firmware = pkgs.callPackage ./aic8800-firmware.nix { };
  alsa-ucm-conf-patches = pkgs.fetchFromGitHub {
    owner = "radxa-pkg";
    repo = "alsa-ucm-conf";
    tag = "1.2.14-1radxa2";
    hash = "sha256-9y+0GxJ/CCA9J0gnRPl+EHxNnQNuKiNceB0dfilPeT4=";
  };
  alsa-ucm-conf-patched = pkgs.alsa-ucm-conf.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      "${alsa-ucm-conf-patches}/debian/patches/0001-ucm2-add-PinePhone-configuration.patch"
      "${alsa-ucm-conf-patches}/debian/patches/0002-ucm2-add-PineTab-configuration.patch"
      "${alsa-ucm-conf-patches}/debian/patches/0003-ucm2-add-improved-Librem-5-profiles.patch"
      "${alsa-ucm-conf-patches}/debian/patches/radxa/0001-add-radxa-dragon-q6a-support.patch"
      "${alsa-ucm-conf-patches}/debian/patches/radxa/0002-fix-radxa-dragon-q6a-config.patch"
      "${alsa-ucm-conf-patches}/debian/patches/radxa/0003-ucm2-Qualcomm-qcs6490-Add-DMI-match-for-Radxa-Dragon.patch"
    ];
  });
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

  systemd.tpm2.enable = false;
  environment.variables.ALSA_CONFIG_UCM2 = "${alsa-ucm-conf-patched}/share/alsa/ucm2";
}
