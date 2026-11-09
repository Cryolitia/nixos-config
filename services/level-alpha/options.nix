{ lib }:

{
  podman = {
    imports = [
      (lib.mkAliasOptionModule [ "features" "podman" "enable" ] [ "virtualisation" "podman" "enable" ])
    ];
    features.podman.enable = lib.mkDefault true;
  };
}
