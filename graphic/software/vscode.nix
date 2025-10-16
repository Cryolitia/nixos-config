{ inputs, pkgs, ... }:

let
  vscode-extensions-input = inputs.nix-vscode-extensions;
  vscode-extensions =
    pkgs.lib.attrsets.recursiveUpdate vscode-extensions-input.extensions.${pkgs.system}
      (vscode-extensions-input.extensions.${pkgs.system}.forVSCodeVersion pkgs.vscode.version);
in

(pkgs.vscode-with-extensions.override {
  vscode = pkgs.nur-cryolitia.vscode-vtuber.override {
    vscode = pkgs.vscode.override {
      # commandLineArgs = "--disable-gpu";
    };
  };
  vscodeExtensions = import ./vscodeExtensions.nix { inherit pkgs vscode-extensions; };
})
