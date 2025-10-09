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
  version = "6.15.7-q6a";
  modDirVersion = "6.15.7";

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
    NOVA_CORE n
    COMPRESSED_INSTALL n
  '';

  kernelPatches = [ ];
  ignoreConfigErrors = true;
}
