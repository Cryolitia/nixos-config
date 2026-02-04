# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./user.nix
    #./dns.nix
    ./software
    ./dn42
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;

  #system.autoUpgrade.enable = true;

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      dates = "daily";
    };
    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };

    settings = {
      narinfo-cache-positive-ttl = 60 * 60 * 24;
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      nix-path = lib.mapAttrsToList (name: path: "${name}=${path}") inputs;

      substituters = [
        "https://mirrors.mirrorz.org/nix-channels/store"
        # "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"

        "https://nix-community.cachix.org"
        "https://cryolitia.cachix.org"
        "http://cache.cryolitia.dn42"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cryolitia.cachix.org-1:/RUeJIs3lEUX4X/oOco/eIcysKZEMxZNjqiMgXVItQ8="
        "kp920.cryolitia.dn42:M68UcYMNX/2yWXFwDb21jAregdcIsF3uIrSmXldX70k="
      ];

      fallback = true;

      # Disable the built-in flake registry to speed up evaluation
      flake-registry = "";
    };

    # This is important. It locks nixpkgs registry used in nix shell
    # to the same of flakes. Saves time.
    registry = ({ pkgs.flake = inputs.self; } // lib.mapAttrs (_: flakes: { flake = flakes; }) inputs);

    # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.

    daemonIOSchedClass = lib.mkDefault "idle";
    daemonCPUSchedPolicy = lib.mkDefault "idle";
  };

  security.sudo.wheelNeedsPassword = false;

  boot = {
    loader.systemd-boot.configurationLimit = 3;
    tmp.cleanOnBoot = true;
    kernel.sysctl = {
      "kernel.sysrq" = 1;
    };
    kernelParams = [ "bdev_allow_write_mounted=0" ];
  };

  programs.ssh = {
    kexAlgorithms = [
      "curve25519-sha256@libssh.org"
      "diffie-hellman-group-exchange-sha256"
      "diffie-hellman-group1-sha1"
    ];
    pubkeyAcceptedKeyTypes = [
      "ssh-ed25519"
      "ssh-rsa"
      "ecdsa-sha2-nistp256"
    ];
  };

  #time.hardwareClockInLocalTime = true;

  zramSwap.enable = true;

  # Sony phone
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0fce", ATTRS{idProduct}=="320d", MODE="0666", GROUP="plugdev"
  '';

  environment.enableAllTerminfo = true;

  services.fwupd.enable = true;

  # avoid hanging other services
  systemd.services.nix-daemon.serviceConfig.Slice = "-.slice";
  # avoid tmpfs overflow
  systemd.tmpfiles.rules = [ "D /nix/tmp 0755 root root -" ];
  systemd.services.nix-daemon.environment.TMPDIR = "/nix/tmp";
  # always use the daemon
  environment.variables.NIX_REMOTE = "daemon";

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel"))
        return polkit.Result.YES;
    });
  '';
}
