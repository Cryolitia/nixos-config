{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./common.nix
    ./hardware-configuration.nix
    ../../common
    ../../hardware/sound.nix
    ../../graphic/desktop/niri.nix
    ../../graphic/software
    ./hamradio.nix
  ];

  boot = {
    loader.timeout = lib.mkDefault 5;

    kernelParams = [
      "loglevel=8"
    ];
  };

  systemd.enableEmergencyMode = true;

  hardware.uinput.enable = true;

  networking.hostName = "q6a-nixos";

  services.openssh.enable = true;

  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  nix.extraOptions = ''
    extra-platforms = aarch64-linux
  '';

  virtualisation.podman.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 6 * 1024;
    }
  ];

  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "cryolitia";
  };

  environment.systemPackages = with pkgs; [
    helvum
    alsa-utils
    slurp
  ];

  xdg.portal = {
    enable = true;
    config.niri = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Secret" = [
        "gnome-keyring"
      ];
    };
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-gstreamer
    ];
  };

  hardware.bluetooth.enable = false;
}
