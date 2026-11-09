{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ (import ../options.nix { inherit lib; }).podman ];

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion =
            config.virtualisation.oci-containers.containers == { }
            || config.virtualisation.oci-containers.backend != "podman"
            || config.features.podman.enable;
          message = "Podman OCI containers require features.podman.enable; disable those containers before disabling Podman.";
        }
      ];
    }
    (lib.mkIf config.features.podman.enable {
      environment.systemPackages = [ pkgs.podman-compose ];

      virtualisation.podman = {
        autoPrune = {
          enable = true; # Periodically prune Podman Images not in use.
          dates = "weekly";
          flags = [ "--all" ];
        };
        defaultNetwork.settings = {
          dns_enabled = true; # Enable DNS resolution in the podman network.
        };
      };
    })
  ];
}
