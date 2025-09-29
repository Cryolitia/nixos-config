{
  pkgs,
  inputs,
  lib,
  ...
}:

pkgs.buildLinux {
  defconfig = "qcom_module_defconfig";
  version = "6.15.7-q6a";
  modDirVersion = "6.15.7";
  src = inputs.kernel-q6a;
  
  structuredExtraConfig = with lib.kernel; {
    EFI_ZBOOT = lib.mkForce no;
    NVME_AUTH = lib.mkForce yes;
  };

  extraConfig = ''
    NOVA_CORE n
    COMPRESSED_INSTALL n
  '';

  kernelPatches = [];
  ignoreConfigErrors = true;
}
