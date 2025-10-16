{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./software
    ../../common
    ./hardware/bluetooth.nix
    ../../hardware/sound.nix
    ./dn42
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "initcall_blacklist=hisi_ddrc_pmu_module_init"
      "arm64.nompam"
    ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
  };

  networking = {
    hostName = "kp920-nixos";
    tempAddresses = "disabled";
    firewall.enable = true;
  };

  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  nix.extraOptions = ''
    extra-platforms = aarch64-linux
  '';

  services.nix-serve = {
    enable = true;
    openFirewall = false;
    port = 5000;
    secretKeyFile = "/var/lib/nix-serve-private";
    bindAddress = "*";
    package = pkgs.nix-serve-ng;
  };
  me.cryolitia.services.nginx.external."cache" = 5000;

  users.users.ziyao = {
    isNormalUser = true;
    uid = 1023;
    description = "ziyao233";
    shell = pkgs.bashInteractive;
    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      "docker"
      "input"
      "i2c"
      "plugdev"
    ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEZ7Jy+zBbNGrypUWx+H6DySweWKJMHGG/+HhhTeXd2"
    ];
  };

  users.users.yukari = {
    isNormalUser = true;
    uid = 1024;
    description = "yukari";
    shell = pkgs.bashInteractive;
    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      "docker"
      "input"
      "i2c"
      "plugdev"
    ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$y$j9T$EGb7ThXBnx23/EoU2wMO.0$DVdXLz2Kav0R5j6YUr.ndmhVDeZ7e6TLH6VRy2NU/J4";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBIE+fnfiCeMjA74rEV6DCDg/gdgTJBtOKpW/RTYhpmc"
    ];
  };

  users.users.cmiki = {
    isNormalUser = true;
    uid = 1025;
    description = "Noa Virellia";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      "docker"
      "input"
      "i2c"
      "plugdev"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOz0CMmkGSXv4H77rmrmvadltAlwAZeVimxGoUAfArs"
    ];
  };

  programs.fish.enable = true;

  fileSystems."/mnt/NAS" = {
    device = "/dev/disk/by-uuid/cd1d85fa-f4f7-4d16-898c-0231b324401d";
    fsType = "btrfs";
    options = [ "space_cache=v2" ];
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      item = "nofile";
      type = "-";
      value = "32768";
    }
  ];

  systemd.services."disable-enp3s0" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.iproute2}/bin/ip link set enp3s0 down";
    };
  };
}
