# https://lostattractor.net/archives/nixos-gpu-vfio-passthrough

#IOMMU Group 2:
#        00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07)
#        01:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU116M [GeForce GTX 1660 Ti Mobile] [10de:2191] (rev a1)
#        01:00.1 Audio device [0403]: NVIDIA Corporation TU116 High Definition Audio Controller [10de:1aeb] (rev a1)
#        01:00.2 USB controller [0c03]: NVIDIA Corporation TU116 USB 3.1 Host Controller [10de:1aec] (rev a1)
#        01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU116 USB Type-C UCSI Controller [10de:1aed] (rev a1)

{ pkgs, lib, ... }:

let

  gpuIDs = [
    "10de:2191"
    "10de:1aeb"
    "10de:1aec"
    "10de:1aed"
  ];
in

{
  imports = [ ../../../common/libvirt.nix ];

  system.nixos.tags = [ "No-Nvidia" ];

  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  boot.kernelParams = [
    "intel_iommu=on"
    ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
  ];

  environment.systemPackages = with pkgs; [
    virtiofsd
    looking-glass-client
    nur-cryolitia.MaaAssistantArknights-beta
  ];

  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';

  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
  ];

  systemd.tmpfiles.rules = [
    # Type Path               Mode UID     GID Age Argument
    "f /dev/shm/looking-glass 0660 cryolitia kvm -"
  ];
}
