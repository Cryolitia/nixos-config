{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.pkgsLLVM.linux_latest);

  boot.kernelPatches = [
    {
      name = "Disable DRM";
      features = {
        video = false;
        debug = false;
      };
      patch = null;
      #   extraConfig = ''
      #     DRM n
      #   '';
    }

    # Tracking https://github.com/AOSC-Dev/aosc-os-abbs/tree/stable/runtime-kernel/linux-kernel/autobuild/patches
    {
      name = "0152";
      patch = ./patches/0152-BACKPORT-OPENEULER-arm64-cpufeature-discover-CPU-sup.patch;
    }
    {
      name = "0153";
      patch = ./patches/0153-BACKPORT-OPENEULER-KVM-arm64-Fix-missing-traps-of-gu.patch;
    }
    {
      name = "0154";
      patch = patches/0154-BACKPORT-OPENEULER-arm64-cpufeature-Both-the-major-a.patch;
    }
    {
      name = "0155";
      patch = ./patches/0155-BACKPORT-OPENEULER-Revert-arm64-head.S-Initialise-MP.patch;
    }
    {
      name = "0156";
      patch = ./patches/0156-BACKPORT-OPENEULER-arm64-mpam-Check-mpam_detect_is_e.patch;
    }
    {
      name = "0157";
      patch = ./patches/0157-OPENEULER-arm64-mpam-Fix-redefined-reference-of-mpam.patch;
    }
  ];
}
