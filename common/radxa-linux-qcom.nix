{
  pkgs,
  ...
}:
let
  lib = pkgs.lib;
  version = (lib.importJSON ../version.json).radxa-linux-qcom;
in

pkgs.buildLinux {
  defconfig = "qcom_module_defconfig";
  version = "7.0.2-qcom";
  modDirVersion = "7.0.2";

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
  };

  extraConfig = ''
    COMPRESSED_INSTALL n
  '';

  kernelPatches = [ ];
  ignoreConfigErrors = true;
}
