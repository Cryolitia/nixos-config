{ pkgs, ... }:

{
  imports =
    [
      ./syncthing.nix
      ../../../graphic/software/high-performance.nix
      ../../../graphic/software/aagl.nix
      ../../../graphic/software/steam.nix
      ../../../common/software/transmission.nix
    ];

  environment.systemPackages = with pkgs; [
    nur-cryolitia.gpd-linux-controls
  ];
}
