{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ (import ../options.nix { inherit lib; }).jetbrains ];

  config = lib.mkIf config.features.jetbrains.enable {
    environment.systemPackages =
      let
        packages = import ./packages.nix { inherit inputs pkgs; };
      in
      [
        packages.androidStudioPackages.beta
        packages.idea-ultimate
        packages.pycharm-professional
        packages.rust-rover
        packages.clion
      ];
  };
}
