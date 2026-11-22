{ lib, ... }:
let
  batteryVoltageLabel = "电池组电压";

  temperatureLabel = chip: label: ''
    chip "${chip}-*"
      label temp1 "${label}"
  '';

  numberedTemperatures =
    prefix: label: count:
    lib.concatMapStrings (
      index: temperatureLabel "${prefix}${toString index}_thermal" "${label} ${toString index}"
    ) (lib.range 0 (count - 1));

  cpuTemperatures =
    cluster: firstCpu: count:
    lib.concatMapStrings (
      core:
      numberedTemperatures "cpu_${toString cluster}_${toString core}_"
        "CPU ${toString (firstCpu + core)} 测点"
        2
    ) (lib.range 0 (count - 1));
in
{
  environment.etc."sensors.d/piano.conf".text = ''
    chip "battery-*"
      label in0 "${batteryVoltageLabel}"
      label temp1 "电池组温度"

    chip "bq27z561_0-*"
      label in0 "电芯 0 电压"
      label temp1 "电芯 0 温度"

    chip "bq27z561_1-*"
      label in0 "电芯 1 电压"
      label temp1 "电芯 1 温度"

    chip "piano_mca_usb-*"
      label in0 "USB 输入电压"

    chip "ucsi_source_psy_pmic_glink.ucsi.01-*"
      label in0 "USB-C 协议电压"

    chip "sc8541-*"
      label in0 "充电泵输入电压"
      label temp1 "充电泵芯片温度"
  ''
  + cpuTemperatures 0 0 6
  + cpuTemperatures 1 6 2
  + numberedTemperatures "cpuss_0_" "CPU 子系统 0 测点" 2
  + numberedTemperatures "cpuss_1_" "CPU 子系统 1 测点" 2
  + numberedTemperatures "gpuss" "GPU 测点" 8
  + numberedTemperatures "camera" "SoC 相机单元" 2
  + numberedTemperatures "modem" "基带测点" 4
  + numberedTemperatures "aoss" "常开子系统测点" 4
  + numberedTemperatures "nsphvx" "NSP HVX 测点" 3
  + numberedTemperatures "nsphmx" "NSP HMX 测点" 4
  + temperatureLabel "video_thermal" "SoC 视频单元"
  + temperatureLabel "ddr_thermal" "DDR 子系统"
  + temperatureLabel "ath12k_hwmon" "Wi-Fi 芯片";

  home-manager.users.cryolitia.dconf.settings."org/gnome/shell/extensions/freon" = {
    hot-sensors = lib.mkForce [
      "__max__"
      batteryVoltageLabel
    ];
  };
}
