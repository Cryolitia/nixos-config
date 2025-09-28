{ pkgs, lib, ... }:

{
  imports = [
    ./syncthing.nix
    ../../../graphic/software/high-performance.nix
    ../../../graphic/software/aagl.nix
    ../../../graphic/software/steam.nix
    ../../../common/software/transmission.nix
  ];

  services.zerotierone.enable = true;
  systemd.services.zerotierone.wantedBy = lib.mkForce [ ];

  environment.systemPackages = with pkgs; [
    nur-cryolitia.gpd-linux-controls
    modem-manager-gui
  ];
}
