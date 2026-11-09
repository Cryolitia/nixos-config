{ inputs, pkgs, ... }:

let
  # https://github.com/ezKEa/aagl-gtk-on-nix/pull/279
  animeGamesLauncher = pkgs.anime-games-launcher.override {
    unwrapped = pkgs.anime-games-launcher.unwrapped.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
        pkgs.aws-lc
        pkgs.sqlite
        pkgs.zstd
      ];
    });
  };
in
{
  imports = [
    inputs.aagl.nixosModules.default
  ];

  nix.settings = inputs.aagl.nixConfig; # Set up Cachix
  programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
  programs.anime-games-launcher = {
    enable = true;
    package = animeGamesLauncher;
  };
  #programs.anime-borb-launcher.enable = true;
  programs.honkers-railway-launcher.enable = true;
  #programs.honkers-launcher.enable = true;
}
