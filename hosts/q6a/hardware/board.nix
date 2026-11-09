{
  pkgs,
  config,
  ...
}:
let
  aic8800-firmware = pkgs.callPackage ./aic8800-firmware.nix { };
in
{
  imports = [ ../../../hardware/level-alpha/qcom/nixos.nix ];

  boot = {
    # loader.systemd-boot.installDeviceTree = true;

    extraModulePackages = [
      ((config.boot.kernelPackages.callPackage ./aic8800.nix { }).usb)
    ];

    kernelModules = [
      "aic8800_fdrv"
      "aic_load_fw"
    ];
  };

  hardware = {
    firmware = [ aic8800-firmware ];
    # deviceTree = {
    #   enable = true;
    #   name = "qcom/qcs6490-radxa-dragon-q6a.dtb";
    # };
  };

  services.speechd.enable = false;
}
