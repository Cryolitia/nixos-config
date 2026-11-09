{ inputs, pkgs, ... }:

(pkgs.vscode-with-extensions.override {
  vscode = pkgs.nur-cryolitia.vscode-vtuber.override {
    vscode = pkgs.vscode.override {
      # commandLineArgs = "--disable-gpu";
    };
  };
  vscodeExtensions = import ./extensions.nix {
    inherit inputs pkgs;
    version = pkgs.vscode.version;
  };
})
