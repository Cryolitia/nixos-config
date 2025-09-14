{ pkgs, inputs, ... }:

pkgs.buildLinux {
  defconf = "qcom_module_defconfig";
  version = "6.15.7-q6a";
  modDirVersion = "6.15.7";
  src = inputs.kernel-q6a;
}
