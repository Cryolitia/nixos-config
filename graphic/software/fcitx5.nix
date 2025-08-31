{ pkgs, config, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        libsForQt5.fcitx5-qt
        (fcitx5-rime.override {
          rimeDataPkgs = import ../software/rime-data.nix {
            inherit config;
            inherit pkgs;
          };
        })
        fcitx5-nord
        fcitx5-material-color
      ];
    };
  };
}
