{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.features.ime == "ibus") {
    i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [
      (rime.override {
        rimeDataPkgs = import ./rime-data.nix { inherit pkgs; };
      })
      libpinyin
    ];
  };
}
