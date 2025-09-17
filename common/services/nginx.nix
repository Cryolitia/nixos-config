{
  config,
  lib,
  ...
}:
let
  cfg = config.me.cryolitia.services.nginx;
  domainList = [
    "crylt.dn42"
    "kp920.internal"
    "kp920.cryolitia.dn42"
    "kp920.site-01.cryolitia.dn42"
    "kp920.crylt.dn42"
    "kp920.site-01.crylt.dn42"
  ];
in
{
  options = {
    me.cryolitia.services.nginx = {
      external = lib.mkOption {
        type = lib.types.attrsOf (lib.types.ints.between 1 65535);
        default = { };
      };
      internal = lib.mkOption {
        type = lib.types.attrsOf (lib.types.ints.between 1 65535);
        default = { };
      };
    };
  };

  config = {
    services.nginx = {
      statusPage = true;
      recommendedProxySettings = true;
      virtualHosts = lib.attrsets.mapAttrs' (
        name: value:
        lib.attrsets.nameValuePair "${name}.cryolitia.dn42" {
          serverAliases = lib.lists.forEach domainList (x: "${name}.${x}");
          listenAddresses = [
            "0.0.0.0"
            "[::]"
          ];
          locations."/" = {
            proxyPass = "http://127.0.0.1:${builtins.toString value}";
            proxyWebsockets = true; # needed if you need to use WebSocket
            extraConfig =
              # required when the target is also TLS server with multiple hosts
              "proxy_ssl_server_name on;"
              +
                # required when the server wants to use HTTP Authentication
                "proxy_pass_header Authorization;"
              + ''
                allow 127.0.0.1;
                allow ::1;
                allow 192.168.0.0/16;
                allow fd00::/7;
                deny all;
              '';
          };
        }
      ) cfg.external;
    };

    networking.firewall.allowedTCPPorts =
      (lib.optionals config.services.nginx.enable [ 80 ])
      ++ (lib.optionals (!config.services.nginx.enable) (
        lib.attrsets.mapAttrsToList (_: value: value) cfg.external
      ));
  };
}
