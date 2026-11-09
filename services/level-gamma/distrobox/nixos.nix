{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    (import ../options.nix { inherit lib; }).distrobox
    ../../level-alpha/podman/nixos.nix
  ];

  config = lib.mkIf config.features.distrobox.enable {
    features.podman.enable = lib.mkDefault true;
    assertions = [
      {
        assertion = config.features.podman.enable;
        message = "Distrobox requires features.podman.enable; disable Distrobox before disabling Podman.";
      }
    ];
    environment.systemPackages = [ pkgs.distrobox ];
  };
}
