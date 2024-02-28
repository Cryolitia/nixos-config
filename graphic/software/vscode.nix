{ pkgs, inputs, lib, ... }:

with lib;
let

  vscode-extensions-input = inputs.nix-vscode-extensions.extensions.${pkgs.system};
  vscode-extensions = lib.attrsets.recursiveUpdate
    vscode-extensions-input
    (vscode-extensions-input.forVSCodeVersion pkgs.vscode.version);

in

{
    environment.systemPackages = with pkgs; [
        (vscode-with-extensions.override {
            vscode = pkgs.vscode.override {
                commandLineArgs = "--disable-gpu";
            };
            vscodeExtensions = (with vscode-extensions.vscode-marketplace; [
                ms-ceintl.vscode-language-pack-zh-hans
                jnoortheen.nix-ide
                github.vscode-pull-request-github
                brunnerh.insert-unicode
                tecosaur.latex-utilities
                james-yu.latex-workshop
                davidanson.vscode-markdownlint
                equinusocio.vsc-material-theme
                equinusocio.vsc-material-theme-icons
                esbenp.prettier-vscode
                medo64.code-point
                s-nlf-fh.glassit
                eamodio.gitlens
                twxs.cmake
                m4ns0ur.base64
                uctakeoff.vscode-counter
                rust-lang.rust-analyzer
                nvarner.typst-lsp
            ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                    name = "remote-ssh";
                    publisher = "ms-vscode-remote";
                    version = "0.102.0";
                    sha256 = "sha256-YQ0Dy1C+xEGtwh0z97ypIMUq8D7PozVRb6xXUVZsjBw=";
                }
            ];
        })
    ];
}
