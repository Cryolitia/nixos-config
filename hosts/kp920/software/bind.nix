{ lib, ... }:

{
  services.bind = {
    enable = true;
    listenOn = lib.mkForce [ "any" ];
    listenOnIpv6 = lib.mkForce [ "any" ];
    listenOnPort = lib.mkForce 1053;
    listenOnIpv6Port = lib.mkForce 1053;
    extraOptions = ''
      allow-recursion { };
      recursion no;
    '';
    zones."cryolitia.dn42" = {
      master = true;
      file = "${../../../common/dn42}/cryolitia.dn42";
    };
    zones."crylt.dn42" = {
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
}
