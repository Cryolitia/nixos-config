{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware/board.nix
    ./hardware-configuration.nix
    ../../profiles/level-beta/nixos.nix
    ../../hardware/level-beta/graphics/nixos.nix
    ../../graphic/level-gamma/obs-studio/nixos.nix
    ../../graphic/level-beta/sunshine/nixos.nix
    ../../services/level-alpha/podman/nixos.nix
    ./hamradio.nix
    ./pipewire.nix
  ];

  home-manager.users.cryolitia = ./home.nix;

  features.desktop = [ "niri" ];

  boot = {
    loader.timeout = lib.mkDefault 5;
    consoleLogLevel = 8;
  };

  systemd.enableEmergencyMode = true;

  hardware.uinput.enable = true;

  networking.hostName = "cryolitia-radxa-q6a-nixos";

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

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 6 * 1024;
    }
  ];

  services.displayManager.autoLogin = {
    enable = true;
    user = "cryolitia";
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    slurp
  ];

  hardware.bluetooth.enable = false;
}
