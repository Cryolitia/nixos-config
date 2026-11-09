{
  pkgs,
  ...
}:
let
  lib = pkgs.lib;
  version = (lib.importJSON ../../../version.json).radxa-linux-qcom;
in

pkgs.buildLinux {
  defconfig = "qcom_module_defconfig";
  version = "7.0.11-qcom";
  modDirVersion = "7.0.11";

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

  kernelPatches = [
    {
      name = "tools-add-128-bit-integer-types-for-aarch64";
      patch = pkgs.fetchpatch {
        url = "https://github.com/torvalds/linux/commit/10a47fb67340bca274276faf855d7d460afd9a7a.patch";
        hash = "sha256-w6ZnvodW2kS3bqtZVvVN5qDt1Zc7fJvnywki3MBsER0=";
      };
    }
  ];
  ignoreConfigErrors = true;
}
