{ config, lib, ... }:
{
  imports = [
    (import ../options.nix { inherit lib; }).input-method
    ./fcitx5.nix
    ./ibus.nix
  ];

  i18n.inputMethod = {
    enable = true;
    type = config.features.ime;
  };

  home-manager.users.cryolitia = import ./hm.nix;
}
