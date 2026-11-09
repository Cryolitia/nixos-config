{ pkgs, lib, ... }:
{
  imports = [ ./syncthing.nix ];

  services.zerotierone.enable = true;
  systemd.services.zerotierone.wantedBy = lib.mkForce [ ];

  environment.systemPackages = with pkgs; [
    nur-cryolitia.gpd-linux-controls
    modem-manager-gui
  ];
}
