{ pkgs, lib, ... }:
let
  dnsmasq-china-list = (lib.importJSON ../../../version.json).dnsmasq-china-list;
  dnsmasq-china-list-pkgs = pkgs.stdenvNoCC.mkDerivation {
    pname = "dnsmasq-china-list";
    version = "0-unstable";
    src = pkgs.fetchFromGitHub {
      inherit (dnsmasq-china-list)
        owner
        repo
        rev
        hash
        ;
    };

    buildPhase = ''
      runHook preBuild

      sed -i '/^server=/!d' accelerated-domains.china.conf
      sed -i 's/^server=\/\([^/]*\)\/.*$/\1/g' accelerated-domains.china.conf

      sed -i '/^server=/!d' apple.china.conf
      sed -i 's/^server=\/\([^/]*\)\/.*$/\1/g' apple.china.conf

      sed -i '/^server=/!d' google.china.conf
      sed -i 's/^server=\/\([^/]*\)\/.*$/\1/g' google.china.conf

      sed -i '/^bogus-nxdomain=/!d' bogus-nxdomain.china.conf
      sed -i 's/^bogus-nxdomain=//g' bogus-nxdomain.china.conf

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/dnsmasq-china-list
      install -Dm644 -v *.conf -t $out/share/dnsmasq-china-list/

      runHook postInstall
    '';
    meta = with lib; {
      description = "Chinese-specific configuration to improve your favorite DNS server. Best partner for chnroutes";
      homepage = "https://github.com/felixonmars/dnsmasq-china-list";
      lincense = lincense.wtfpl;
      maintainers = with maintainers; [ Cryolitia ];
    };
  };

  confFile = pkgs.writeText "smartdns.conf" ''
    bind [fdd2:4372:796f::1]:53
    speed-check-mode ping,tcp:80,tcp:443
    prefetch-domain yes
    dualstack-ip-selection yes
    log-level info
    log-console yes
    audit-enable yes
    audit-console yes

    server-tls 8.8.8.8
    server-tls 8.8.4.4
    server-tls [2001:4860:4860::8888]
    server-tls [2001:4860:4860::8844]
    server-tls 1.1.1.1
    server-tls 1.0.0.1
    server-tls [2606:4700:4700::1111]
    server-tls [2606:4700:4700::1001]

    server [fdd2:4372:796f::] -g cn -e
    server [fdd2:4372:796f::] -g internal -e
    server 127.0.0.1 -g DN42local -e
    server [fd42:d42:d42:53::1] -g DN42 -e
    server [fd42:d42:d42:54::1] -g DN42 -e

    domain-set -name cn -file ${dnsmasq-china-list-pkgs}/share/dnsmasq-china-list/accelerated-domains.china.conf
    domain-set -name apple -file ${dnsmasq-china-list-pkgs}/share/dnsmasq-china-list/apple.china.conf
    domain-set -name google -file ${dnsmasq-china-list-pkgs}/share/dnsmasq-china-list/google.china.conf

    force-AAAA-SOA yes

    domain-rules /internal/ -nameserver internal -address -4
    domain-rules /crylt.dn42/ -nameserver DN42local -address -6
    domain-rules /cryolitia.dn42/ -nameserver DN42local -address -6
    domain-rules /f.6.9.7.2.7.3.4.2.d.d.f.ip6.arpa/ -nameserver DN42local
    domain-rules /dn42/ -nameserver DN42 -address -6
    domain-rules /d.f.ip6.arpa/ -nameserver DN42
    domain-rules /domain-set:cn/ -nameserver cn -address -6
    domain-rules /domain-set:apple/ -nameserver cn -address -6
    domain-rules /domain-set:google/ -nameserver cn -address -6

    ip-set -name nxdomain -file ${dnsmasq-china-list-pkgs}/share/dnsmasq-china-list/bogus-nxdomain.china.conf
    ip-rules ip-set:nxdomain -bogus-nxdomain

    address /onion/#4
    address /onion/fdd0:5ad7:5f56:1:be24:11ff:fe6a:4be1

    address /steamcontent.com/#6
    nameserver /steamcontent.com/cn
  '';
in
{
  services.smartdns = {
    enable = true;
  };

  systemd.services.smartdns.restartTriggers = lib.mkForce [ confFile ];
  environment.etc."smartdns/smartdns.conf".source = lib.mkForce confFile;
}
