{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.features.ime == "fcitx5") {
    i18n.inputMethod.fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        libsForQt5.fcitx5-qt
        (fcitx5-rime.override {
          rimeDataPkgs = import ./rime-data.nix { inherit pkgs; };
        })
        fcitx5-nord
        fcitx5-material-color
      ];
    };
  };
}
