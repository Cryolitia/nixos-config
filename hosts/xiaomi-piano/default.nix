{ inputs, ... }:
{
  imports = [
    inputs.xiaomi-piano.nixosModules.piano
    ../../profiles/level-beta/nixos.nix
    ../../graphic/level-gamma/steam/nixos.nix
  ];

  networking.hostName = "cryolitia-xiaomi-piano-nixos";

  features.desktop = [
    "gnome"
    "niri"
  ];
  features.ime = "fcitx5";

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        installDeviceTree = true;
      };
      efi.canTouchEfiVariables = false;
      timeout = 5;
    };
    initrd.systemd.tpm2.enable = false;
  };
  systemd.tpm2.enable = false;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-partlabel/sunuefi_root";
      fsType = "ext4";
      autoResize = true;
    };
    "/boot" = {
      device = "/dev/disk/by-partlabel/sunuefi_esp";
      fsType = "vfat";
      options = [
        "nosuid"
        "nodev"
        "noexec"
      ];
    };
  };

  # Keep internal UFS volumes out of desktop storage lists.
  services.udev.extraRules = ''
    SUBSYSTEM=="block", DRIVERS=="ufshcd-qcom", ENV{UDISKS_IGNORE}="1"
  '';

  # Compatibility versions for this device's initial installation.
  system.stateVersion = "26.11";
  home-manager.users.cryolitia =
    { lib, ... }:
    {
      home.stateVersion = "26.11";
      dconf.settings."org/gnome/shell/extensions/dash-to-dock".show-mounts-network = lib.mkForce false;
      dconf.settings."org/gnome/shell/extensions/freon".hot-sensors = lib.mkForce [
        "__max__"
        "in0"
      ];
      # Use the keyboard layout with Fcitx5 and Kimpanel.
      dconf.settings."org/gnome/desktop/input-sources".sources = lib.mkForce [
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "cn"
        ])
      ];
    };
}
