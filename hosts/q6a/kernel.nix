{
  pkgs,
  ...
}:
let
  lib = pkgs.lib;
  version = (lib.importJSON ../../version.json).kernel-q6a;
in

pkgs.buildLinux {
  defconfig = "qcom_module_defconfig";
  version = "6.18.2-q6a";
  modDirVersion = "6.18.2";

  src = pkgs.fetchFromGitHub {
    inherit (version)
      owner
      repo
      rev
      hash
      ;
  };

  structuredExtraConfig = with lib.kernel; {
    EFI_ZBOOT = lib.mkForce no;
    NVME_AUTH = lib.mkForce yes;
  };

  extraConfig = ''
    DRM_NOVA n
    NOVA_CORE n
    COMPRESSED_INSTALL n
    WLAN_VENDOR_AIC8800 n
  '';

  kernelPatches = [ ];
  ignoreConfigErrors = true;
}
