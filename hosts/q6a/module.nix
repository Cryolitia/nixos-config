{ inputs, ... }:
let
  commonModule = import ../../common/module.nix { inherit inputs; };
in
(commonModule (import ./home.nix))
++ (with inputs; [

  ./default.nix
  inputs.vscode-server.nixosModules.default

  { services.vscode-server.enable = true; }
])
