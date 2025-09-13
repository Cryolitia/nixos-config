{ pkgs, lib, ... }:

{
  systemd.services."dn42-static" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.iproute2}/bin/ip -6 addr add fdd2:4372:796f::1/64 dev enp4s0f0";
    };
  };

  services.bind = {
    enable = true;
    listenOn = lib.mkForce [ ];
    listenOnIpv6 = lib.mkForce [ "fdd2:4372:796f::1" ];
    extraOptions = ''
      allow-recursion { };
      recursion no;
    '';
    zones."cryolitia.dn42" = {
      master = true;
      file = "${../../../common/dn42}/cryolitia.dn42";
    };
    zones."f.6.9.7.2.7.3.4.2.d.d.f.ip6.arpa" = {
      master = true;
      file = "${../../../common/dn42}/f.6.9.7.2.7.3.4.2.d.d.f.ip6.arpa";
    };
  };

  systemd.services.bind = {
    wants = [ "dn42-static.service" ];
    after = [ "dn42-static.service" ];
  };

  networking.firewall.allowedUDPPorts = [ 53 ];

  networking.resolvconf.useLocalResolver = false;
}
