{ pkgs, inputs, ... }:

{
  services.openvscode-server = {
    enable = true;
    user = "cryolitia";
    group = "users";
    package = (
      pkgs.vscode-with-extensions.override {
        vscode = pkgs.openvscode-server // {
          executableName = "openvscode-server";
        };
        vscodeExtensions = import ../../../graphic/level-beta/vscode/extensions.nix {
          inherit inputs pkgs;
          version = pkgs.openvscode-server.version;
        };
      }
    );
    host = "127.0.0.1";
    port = 4444;
    withoutConnectionToken = true;
  };

  services.nginx.virtualHosts."code.*".locations."/".basicAuthFile =
    pkgs.writeText "cryolitia.passwd" "cryolitia:$2y$05$l7yhPPI3jZwUN1DKIhJHi.0g9YKjNyp0Qax.497/Ww7j2F1rNS7da";

  me.cryolitia.services.nginx.internal."code" = {
    port = 4444;
  };
}
