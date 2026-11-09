{
  imports = [ ../../../hardware/level-alpha/qcom/nixos.nix ];

  boot.loader.systemd-boot.installDeviceTree = true;

  hardware.deviceTree = {
    enable = true;
    name = "qcom/sc8280xp-radxa-dragon-q8b.dtb";
  };
}
