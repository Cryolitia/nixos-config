{ lib }:

{
  distrobox = {
    options.features.distrobox.enable = lib.mkEnableOption "distrobox" // {
      default = true;
    };
  };
}
