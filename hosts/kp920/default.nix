{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./software
    ../../common
    ./hardware/bluetooth.nix
    ../../hardware/sound.nix
    # ./kernel
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages;
    kernelParams = [
      "initcall_blacklist=hisi_ddrc_pmu_module_init"
    ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
  };

  networking.hostName = "kp920-nixos";

  services.openssh.enable = true;

  networking.firewall.enable = true;

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
    openFirewall = true;
    secretKeyFile = "/var/lib/nix-serve-private";
  };

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

  security.pam.loginLimits = [
    {
      domain = "*";
      item = "nofile";
      type = "-";
      value = "32768";
    }
  ];
}
