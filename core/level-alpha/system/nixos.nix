# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ ... }:
{
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;

  #system.autoUpgrade.enable = true;
  boot = {
    loader.systemd-boot.configurationLimit = 3;
    tmp.cleanOnBoot = true;
    kernel.sysctl = {
      "kernel.sysrq" = 1;
    };
    kernelParams = [ "bdev_allow_write_mounted=0" ];
  };
  #time.hardwareClockInLocalTime = true;

  zramSwap.enable = true;
  environment.enableAllTerminfo = true;
  boot.supportedFilesystems = [ "ntfs" ];
}
