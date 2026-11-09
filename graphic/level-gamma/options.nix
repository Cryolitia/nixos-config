{ lib }:
{
  jetbrains = {
    options.features.jetbrains.enable = lib.mkEnableOption "jetbrains";
  };
  waydroid = {
    options.features.waydroid.enable = lib.mkEnableOption "waydroid";
  };
}
