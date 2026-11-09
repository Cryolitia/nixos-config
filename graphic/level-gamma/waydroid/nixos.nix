{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ (import ../options.nix { inherit lib; }).waydroid ];

  config = lib.mkIf config.features.waydroid.enable {
    virtualisation = {
      waydroid.enable = true;
    };

    environment.systemPackages = with pkgs; [ wl-clipboard ];
  };
}
