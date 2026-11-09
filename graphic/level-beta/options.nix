{ lib }:
{
  desktop = {
    options.features.desktop = lib.mkOption {
      type = lib.types.listOf (
        lib.types.enum [
          "gnome"
          "niri"
        ]
      );
      default = [ ];
      description = "Desktop sessions to configure. GNOME uses GDM; Niri alone uses SDDM.";
    };
  };
  input-method = {
    options.features.ime = lib.mkOption {
      type = lib.types.enum [
        "fcitx5"
        "ibus"
      ];
      default = "fcitx5";
      description = "Input method framework to configure on NixOS.";
    };
  };
}
