{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackagesFor (import ./package.nix { inherit pkgs; });
    loader = {
      systemd-boot = {
        enable = true;
        edk2-uefi-shell.enable = true;
      };
      efi.canTouchEfiVariables = false;
    };
    kernelParams = [
      "console=ttyMSM0,115200n8"
      "earlycon"
      "keep_bootcon"
      "clk_ignore_unused"
    ];
    initrd.availableKernelModules = [
      "usb_storage"
      "nvme"
      "xhci_hcd"
    ];
    initrd.systemd.tpm2.enable = false;
  };

  console.earlySetup = true;
  hardware.firmware = [ pkgs.linux-firmware ];
  environment.systemPackages = [ pkgs.fastfetch ];

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  systemd.tpm2.enable = false;
}
