{ pkgs, ... }:

{
  systemd.services."dn42-static" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.iproute2}/bin/ip -6 addr add fdd2:4372:796f::1/64 dev enx6c92bf27043a";
    };
  };

  networking.resolvconf.useLocalResolver = false;

  services.nginx.virtualHosts."guide.*" = {
    listenAddresses = [
      "0.0.0.0"
      "[::]"
    ];
    locations."/".root = "${pkgs.callPackage ./static-pages { }}/share/cryolitia-static-pages";
  };
}
