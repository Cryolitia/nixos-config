{ pkgs, inputs, ... }:

let
  vscode-extensions-input = inputs.nix-vscode-extensions;
  vscode-extensions =
    pkgs.lib.attrsets.recursiveUpdate
      vscode-extensions-input.extensions.${pkgs.stdenv.hostPlatform.system}
      (
        vscode-extensions-input.extensions.${pkgs.stdenv.hostPlatform.system}.forVSCodeVersion
          pkgs.openvscode-server.version
      );
in

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
        vscodeExtensions = import ../../../graphic/software/vscodeExtensions.nix {
          inherit pkgs vscode-extensions;
        };
      }
    );
    host = "127.0.0.1";
    port = 4444;
    withoutConnectionToken = true;
  };

  services.nginx.virtualHosts."code.*".locations."/".basicAuthFile =
    pkgs.writeText "cryolitia.passwd" "cryolitia:$2y$05$l7yhPPI3jZwUN1DKIhJHi.0g9YKjNyp0Qax.497/Ww7j2F1rNS7da";

  me.cryolitia.services.nginx.internal."code" = 4444;
}
