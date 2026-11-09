{ lib, inputs, ... }:
{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
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
        "https://mirrors.cernet.edu.cn/nix-channels/store"
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"

        "https://nix-community.cachix.org"
        "https://cryolitia.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cryolitia.cachix.org-1:/RUeJIs3lEUX4X/oOco/eIcysKZEMxZNjqiMgXVItQ8="
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
  # avoid hanging other services
  systemd.services.nix-daemon.serviceConfig.Slice = "-.slice";
  # avoid tmpfs overflow
  systemd.tmpfiles.rules = [ "D /nix/tmp 0755 root root -" ];
  systemd.services.nix-daemon.environment.TMPDIR = "/nix/tmp";
  # always use the daemon
  environment.variables.NIX_REMOTE = "daemon";
}
